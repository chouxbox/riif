module Riif::DSL
  class Trns < Base
    HEADER_COLUMNS = [
      :trnsid,
      :trnstype,
      :date,
      :accnt,
      :name,
      :klass,
      :amount,
      :docnum,
      :memo,
      :clear,
      :toprint,
      :addr1,
      :addr2,
      :addr3,
      :addr4,
      :addr5,
      :saddr1,
      :saddr2,
      :saddr3,
      :saddr4,
      :saddr5,
      :duedate,
      :terms,
      :paid,
      :paymeth,
      :shipdate,
      :rep,
      :ponum,
      :invtitle,
      :invmemo
    ]
    START_COLUMN = 'TRNS'
    END_COLUMN = 'ENDTRNS'

    def headers
      [
        ["!#{START_COLUMN}"].concat(HEADER_COLUMNS.upcase_if_not_klass),
        ["!SPL"].concat(Spl::HEADER_COLUMNS.upcase_if_not_klass),
        ["!#{END_COLUMN}"]
      ]
    end

    def upcase_if_not_klass(header_columns)
      labels = []
      header_columns.each do |h|
        if h != 'klass'
          labels.concat(h.upcase)
        else
          labels.concat('CLASS')
        end
      end
      labels
    end


    def rows
      @rows << [END_COLUMN]
    end

    def spl(&block)
      Spl.new.build(&block)[:rows].each do |row|
        @rows << row
      end
    end
  end
end
