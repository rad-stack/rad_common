module RadCommon
  module RadTableHelper
    def rad_table_classes(rad_table)
      classes = ['table']
      classes << 'table-striped' if rad_table.striped?
      classes << 'table-bordered' if rad_table.bordered?
      classes << 'table-hover' if rad_table.hover?
      classes << 'table-sm' if rad_table.small?
      classes.join(' ')
    end
  end
end
