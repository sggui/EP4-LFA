require_relative 'maquina-turing-universal'
require_relative 'mt-multiplicacao'

puts "====================================================================="

input = MtMultiplicacao.linker + '$' + MtMultiplicacao.codificacao_palavra
mtu = MTU.new

puts "Entrada:\n #{input}"
puts "Decidiu? #{mtu.processar(input)}"
puts "Fita Resultante:\n #{mtu.fita}"
puts "Cursor parou em #{mtu.cursor}"
puts "Cursor no estado #{mtu.estado}"
puts "Cursor está lendo \"#{mtu.fita[mtu.cursor]}\""