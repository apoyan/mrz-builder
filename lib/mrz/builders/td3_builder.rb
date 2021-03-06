module Mrz::Builders
  class TD3Builder < BaseBuilder

    PASSPORT_CODE = 'P'
    FIRST_LINE_START = 0
    FIRST_LINE_END = 43
    SECOND_LINE_START = 44
    SECOND_LINE_END = 87

    CD_START1 = 44
    CD_START2 = 57
    CD_START3 = 65
    CD_END1 = 53
    CD_END2 = 63
    CD_END3 = 86
    PAD_OUT_TO = 39

    attr_accessor :type, :country, :first_name, :middle_name, :last_name, :document_number, :nationality,
                  :birth_date, :gender, :expire_date, :optional_data, :code

    def initialize(params)
      @code = PASSPORT_CODE
      @type = Mrz::Formatters::Base::SEPARATOR
      @country = params[:country]
      @first_name = params[:first_name]
      @middle_name = params[:middle_name]
      @last_name = params[:last_name]
      @document_number = params[:document_number]
      @nationality = params[:nationality]
      @birth_date = params[:birth_date]
      @gender = params[:gender]
      @expire_date = params[:expire_date]
      @optional_data = params[:optional]
    end

    def generate
      concat_type
      concat_country
      concat_name
      concat_check_digit(concat_document_number)
      concat_nationality
      concat_check_digit(concat_birth_date)
      concat_gender
      concat_check_digit(concat_expire_date)
      concat_check_digit(concat_optional_data)
      concat_final_check_digit

      [code[FIRST_LINE_START..FIRST_LINE_END], code[SECOND_LINE_START..SECOND_LINE_END]]
    end

    private

    def concat_final_check_digit
      concat(
        calculate_check_digit(
          code[CD_START1..CD_END1] + code[CD_START2..CD_END2] + code[CD_START3..CD_END3]
        )
      )
    end

    def concat_name
      concat(Mrz::Formatters::Name.new(first_name, last_name, middle_name).format(PAD_OUT_TO))
    end

    def concat_type
      concat(Mrz::Formatters::Type.new(type, 0).format)
    end

    def concat_optional_data
      concat(Mrz::Formatters::OptionalData.new(optional_data.to_s, 14).format)
    end

  end
end
