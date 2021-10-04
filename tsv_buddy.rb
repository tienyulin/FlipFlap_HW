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
      @data << title.zip(@tsv_data[i].split("\t").map(&:chomp)).to_h
    end

    @data
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    @tsv_string = ''
    @title = @data[0].keys

    write_title_to_tsv_string
    write_content_to_tsv_string

    @tsv_string
  end

  def write_title_to_tsv_string
    0.upto @title.size - 1 do |i|
      @tsv_string += "\t" if i.positive?
      @tsv_string += @title[i]
    end
    @tsv_string += "\n"
  end

  def write_content_to_tsv_string
    0.upto @data.size - 1 do |j|
      0.upto @title.size - 1 do |k|
        @tsv_string += "\t" if k.positive?
        @tsv_string += @data[j][@title[k]].to_s
      end
      @tsv_string += "\n"
    end
  end
end
