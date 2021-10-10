# frozen_string_literal: true

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    @tsv_data = tsv.split("\n")
    title = @tsv_data[0].split("\t")

    @data = []
    1.upto @tsv_data.size - 1 do |i|
      @data << title.zip(@tsv_data[i].split("\t")).to_h
    end

    @data
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    headers = @data[0].each_key.map { |key| key }.join("\t")
    rows = @data.map { |row| "\n#{row.values.join("\t")}" }
    [headers, rows, "\n"].join
  end
end
