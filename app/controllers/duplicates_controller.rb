class DuplicatesController < ApplicationController
  def index
    skip_policy_scope

    @model = model
    @record = gather_record

    if @record.nil?
      skip_authorization
      flash[:success] = 'Congratulations, there are no more duplicates found!'
      redirect_to root_path
      return
    end

    authorize @record, :index_duplicates?

    @records = []
    @duplicates_count = model.relevant_duplicates.count

    @records = @record.duplicates
    return if @records.count.positive?

    @record.process_duplicates

    flash[:error] = "Invalid #{model.to_s.downcase} data, perhaps something has changed or another user has " \
                    'resolved these duplicates.'

    redirect_to root_path
  end

  def merge
    @record = model.find_by(id: params[:id])
    authorize @record, :merge_duplicates?

    if params[:merge_data]
      status, message = @record.merge_duplicates(params[:merge_data].keys, current_user)

      flash[status] = message

      if status == :error
        notify_user "Unable to process duplicates for #{@record.class} #{@record.id}", message
      else
        subject = "The duplicates for #{@record.class} '#{@record}' were successfully resolved."
        notify_user subject, subject
      end

      redirect_to index_path
    else
      flash[:error] = 'Missing parameters'
      redirect_back(fallback_location: root_path)
    end
  end

  def not
    @record = model.find_by(id: params[:id])
    authorize @record, :not_duplicate?
    other_record = model.find_by(id: params[:master_record])

    if other_record.present?
      if policy(other_record).destroy?
        @record.not_duplicate(other_record)
      else
        flash[:error] = 'You do not have authorization to modify this record.'
        redirect_to index_path
        return
      end
    else
      flash[:error] = "This record doesn't exist, perhaps it was deleted."
      redirect_to index_path
      return
    end

    message = "The #{other_record.class} with id of #{other_record.id} '#{other_record}' was marked as not a duplicate."
    notify_user message, message

    flash[:success] = message
    redirect_to index_path
  end

  def do_later
    @record = model.find_by(id: params[:id])
    authorize @record, :duplicate_do_later?

    max = Duplicate.where(duplicatable_type: model.name).maximum(:sort)
    sort = (max ? max + 1 : 1)
    @record.create_or_update_metadata! sort: sort

    if @record.duplicate.present? && @record.duplicate.score.present?
      dupes = @record.duplicates

      if dupes.count == 1
        record = dupes.first[:record]
        record.create_or_update_metadata! sort: sort
      end
    end

    flash[:notice] = "#{model} was successfully updated."
    redirect_to index_path
  end

  def reset
    @record = model.find_by(id: params[:id])
    authorize @record, :reset_duplicates?

    @record.reset_duplicates
    redirect_to @record
  end

  def switch
    @record = model.find(params[:id])
    record = other_model.find(params[:other_id])

    authorize @record, :reset_duplicates?
    authorize record, :reset_duplicates?

    @record.reset_duplicates
    record.reset_duplicates

    redirect_to resolve_duplicates_path model: @record.class, id: @record.id
  end

  def check_duplicate
    @record = model.new(params[:record].permit!.to_h.except(:authenticity_token, :create_anyway))
    authorize @record, :create?

    @record.valid?
    found_duplicates = @record.find_duplicates

    if found_duplicates.present?
      duplicates = found_duplicates.map do |dupe|
        { duplicate_data: dupe.duplicate_fields, duplicate_path: "/#{model.table_name}/#{dupe.id}" }
      end

      render json: { duplicate: true, duplicates: duplicates }
    else
      render json: { duplicate: false }
    end
  end

  private

    def index_path
      "/rad_common/duplicates?model=#{model}"
    end

    def gather_record
      if params[:id].present?
        @model.relevant_duplicates.where(id: params[:id]).first
      else
        @model.relevant_duplicates.order(sort: :asc, score: :desc, updated_at: :desc, id: :desc).limit(1).first
      end
    end

    def model
      Object.const_get params[:model]
    end

    def other_model
      Object.const_get params[:other_model]
    end

    def notify_user(subject, message)
      RadMailer.simple_message(current_user, subject, message, email_options).deliver_later
    end

    def email_options
      { email_action: { message: 'Click here to view the details.',
                        button_text: 'View',
                        button_url: url_for(@record) } }
    end
end
