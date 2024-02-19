module PrawnSetupFont
  def setup_font!
    font_path = "#{Gem::Specification.find_by_name('rad_common').gem_dir}/app/assets/fonts/"
    font_families.update(
      'DejaVuSans' => {
        normal: "#{font_path}DejaVuSans.ttf",
        italic: "#{font_path}DejaVuSansCondensed-Oblique.ttf",
        bold: "#{font_path}DejaVuSans-Bold.ttf",
        bold_italic: "#{font_path}DejaVuSansCondensed-BoldOblique.ttf"
      }
    )

    font 'DejaVuSans'
  end
end

Prawn::Document.include PrawnSetupFont
