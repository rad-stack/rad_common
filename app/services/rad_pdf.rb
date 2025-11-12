class RadPDF < Prawn::Document
  def initialize(options = {})
    super(options)
    setup_font!
  end

  def fallback_fonts
    ['OpenSans']
  end

  private

    def setup_font!
      font_path = "#{Gem::Specification.find_by_name('rad_common').gem_dir}/app/assets/fonts/"
      font_families.update(
        'OpenSans' => {
          normal: "#{font_path}OpenSans-Regular.ttf",
          italic: "#{font_path}OpenSans-Italic.ttf",
          bold: "#{font_path}OpenSans-Bold.ttf",
          bold_italic: "#{font_path}OpenSans-BoldItalic.ttf"
        }
      )
    end
end
