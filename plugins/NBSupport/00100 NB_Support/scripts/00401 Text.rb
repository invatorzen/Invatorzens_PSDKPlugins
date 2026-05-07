module PFM
  module Text
    # Patch module adding the \f[a§b§c] gender-variable token to message parsing.
    # The token expands to one of the §-separated segments based on the gender variable
    # (e.g. "\f[she§he§they]" picks "she", "he", or "they").
    module NBSupportText
      # Override of {PFM::Text.parse_string_for_messages} that resolves the \f[a§b§c]
      # gender-variable token before delegating to PSDK's parser
      # @param text [String] text to parse
      # @return [String] parsed text ready to be displayed
      def parse_string_for_messages(text)
        return super if text.empty?

        gender = Inva::NBSupport.gender
        preprocessed = text.dup
        preprocessed.gsub!(/\\f\[([^\]]+)\]/i) { $1.split('§')[gender] }
        super(preprocessed)
      end
    end
    class << self
      prepend NBSupportText
    end
  end
end
