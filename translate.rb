require 'rest-client'
require 'json'

class Translate
    def initialize
        @url = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
        @key = 'trnsl.1.1.20230417T205234Z.9acbeba5125c3e7a.1e8a96263a7d5d165c6b65579a71a47255cfbb55'
		
        puts 'Digite o texto que deseja traduzir: '
		@text = gets
        puts 'Informe o idioma do texto atual: '
        puts 'Exemplo: pt, en, fr, es, ru...'    
		@lang = gets.chomp
        puts 'Informe o idioma para qual deseja traduzir: '
        puts 'Exemplo: pt, en, fr, es, ru...'        
		@lang += "-" + gets.chomp

		@response = get_response
		file
	end

	def get_response
		response = RestClient.get(@url,
			params: {
				key: @key,
				text: @text,
				lang: @lang,
			}
		)
		return response
	end

	def text_translation
		JSON.parse(@response)["text"]
	end
	
	def file
		puts "Texto traduzido com sucesso!!"
		time = Time.new
		file = File.open(time.strftime("%m-%d-%Y.%H.%M.%S") + ".txt", 'w') do |line|
			line.puts @lang
			line.puts "\n---Texto original: ---"
            line.puts @text 
			line.puts "\n---Texto traduzido: ---"
            line.puts text_translation
		end
	end
end

init = Translate.new