module DuplicateContactActions
  extend ActiveSupport::Concern

  def show_current_duplicates
    @model = model
    @record = gather_record

    if @record.nil?
      skip_authorization
      flash[:success] = 'Congratulations, there are no more duplicates found!'
      redirect_to root_path
      return
    end

    authorize @record

    @records = []
    @duplicates_count = model.relevant_duplicates.count

    @records = @record.duplicates
    if @records.count.positive?
      render 'layouts/show_current_duplicates'
      return
    end

    @record.process_duplicates

    flash[:error] = "Invalid #{model.to_s.downcase} data, perhaps something has changed or another user has "\
                    'resolved these duplicates.'

    redirect_to show_current_duplicates_path
  end

  def plural_model_name
    model.to_s.downcase.pluralize(2)
  end

  def show_current_duplicates_path
    "/#{plural_model_name}/show_current_duplicates"
  end

  def merge_duplicates
    @record = model.find_by(id: params[:id])
    authorize @record

    if params[:merge_data]
      MergeDuplicatesJob.perform_later(params[:merge_data].keys, @record.class.to_s, @record.id, current_user.id)

      flash[:success] = "The duplicates are processing, we'll email you when complete."
      redirect_to show_current_duplicates_path
    else
      flash[:error] = 'Missing parameters'
      redirect_back(fallback_location: root_path)
    end
  end

  def not_duplicate
    @record = model.find_by(id: params[:id])
    authorize @record
    other_record = model.find_by(id: params[:master_record])

    if other_record # else it's no longer there, moot point
      if policy(other_record).destroy?
        @record.not_duplicate(other_record)
      else
        flash[:error] = 'You do not have authorization to modify this record.'
        redirect_to show_current_duplicates_path
        return
      end
    end

    flash[:success] = 'The record was marked as not a duplicate.'
    redirect_to show_current_duplicates_path
  end

  def duplicate_do_later
    @record = model.find_by(id: params[:id])
    authorize @record

    max = Duplicate.where(duplicatable_type: model.name).maximum(:duplicate_sort)
    sort = (max ? max + 1 : 1)
    @record.create_or_update_metadata! duplicate_sort: sort

    if @record.duplicate.present? && @record.duplicate.duplicate_score.present?
      dupes = @record.duplicates

      if dupes.count == 1
        record = dupes.first[:record]
        record.create_or_update_metadata! duplicate_sort: sort
      end
    end

    flash[:notice] = "#{model} was successfully updated."
    redirect_to show_current_duplicates_path
  end

  def reset_duplicates
    @record = model.find_by(id: params[:id])
    authorize @record

    @record.reset_duplicates
    redirect_to @record
  end

  private

    def gather_record
      if params[id_attribute]
        record = @model.find_by(id: params[id_attribute])
        record&.process_duplicates
        @model.relevant_duplicates.where(id: params[id_attribute]).first
      else
        record = @model.relevant_duplicates.order(duplicate_sort: :asc, duplicate_score: :desc)
        record = record.order(:sales_rep_id) if @model.new.respond_to?(:sales_rep_id)
        record = record.order(updated_at: :desc, id: :desc)
        record.limit(1).first
      end
    end

    def model
      Object.const_get controller_name.classify
    end

    def id_attribute
      "#{controller_name.singularize}_id"
    end
end
