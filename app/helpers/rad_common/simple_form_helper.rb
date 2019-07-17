module RadCommon
  module SimpleFormHelper
    def base_errors(form)
      form.error :base, class: 'alert alert-danger' if form.object.errors[:base].present?
    end
  end
end
