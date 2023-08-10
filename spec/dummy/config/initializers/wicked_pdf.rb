# WickedPDF Global Configuration
#
# Use this to set up shared configuration options for your entire application.
# Any of the configuration options shown here can also be applied to single
# models by passing arguments to the `render :pdf` call.
#
# To learn more, check out the README:
#
# https://github.com/mileszs/wicked_pdf/blob/master/README.md
return unless RadConfig.use_wicked?

config = {
  layout: 'application_pdf',
  disposition: 'attachment',
  orientation: 'Portrait',
  page_size: 'Letter',
  page_height: '11in',
  page_width: '8.5in',
  print_media_type: true,
  no_background: true
}
if Rails.env.production? || Rails.env.staging?
  config[:exe_path] = Gem.bin_path('wkhtmltopdf-heroku', 'wkhtmltopdf-linux-amd64')
end
WickedPdf.config = config
