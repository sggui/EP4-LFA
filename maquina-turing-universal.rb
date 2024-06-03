class MTU
  attr_accessor :fita, :estado, :cursor, :estado_leitura, :simbolo_leitura, :estado_destino, :simbolo_escrita,
                :movimento, :transicoes

  def initialize
    @estado = :qi # Estado inicial
    @cursor = 0 # Posição inicial do cursor na fita
  end

  def processar(entrada)
    # Inicializa a fita com delimitadores, a entrada e espaços em branco adicionais
    @fita = '#' + entrada + '_' * entrada.size * 5 + ' '

    # Variáveis para armazenar a transição
    estado_leitura = ''
    simbolo_leitura = ''
    estado_destino = ''
    simbolo_escrita = ''
    movimento = :D
    transicoes = {}
    @fita_cadeia = []

    while true
      case [@estado, @fita[@cursor]]

      # Estado inicial, lê o delimitador inicial '#'
      in [:qi, '#']
        operar('#', :q0, :D)

      # Leitura do estado de leitura 'f'
      in [:q0, 'f']
        estado_leitura << 'f'
        operar('f', :q1, :D)
      in [:q1, 'a']
        estado_leitura << 'a'
        operar('a', :q1, :D)
      in [:q1, 'b']
        estado_leitura << 'a'
        operar('b', :q1, :D)

      # Leitura do símbolo
      in [:q1, '_']
        simbolo_leitura << '_'
        operar('_', :q2, :D)
      in [:q1, 's']
        simbolo_leitura << 's'
        operar('s', :q2, :D)
      in [:q2, 'c']
        simbolo_leitura << 'c'
        operar('c', :q2, :D)

      # Leitura do estado de destino 'f'
      in [:q2, 'f']
        estado_destino << 'f'
        operar('f', :q5, :D)
      in [:q5, 'a']
        estado_destino << 'a'
        operar('a', :q5, :D)
      in [:q5, 'b']
        estado_destino << 'b'
        operar('b', :q5, :D)

      # Leitura do símbolo a ser escrito
      in [:q5, '_']
        simbolo_escrita << '_'
        operar('_', :q6, :D)
      in [:q5, 's']
        simbolo_escrita << 's'
        operar('s', :q6, :D)
      in [:q6, 'c']
        simbolo_escrita << 'c'
        operar('c', :q6, :D)

      # Leitura do movimento
      in [:q6, 'd']
        movimento = :D
        operar('d', :q8, :D)
      in [:q6, 'e']
        movimento = :E
        operar('e', :q8, :D)

      # Armazenamento da transição lida
      in [:q8, 'f']
        leitura = [estado_leitura, simbolo_leitura]
        transicoes[leitura] = [simbolo_escrita, estado_destino, movimento]
        puts("Transição lida: (#{estado_leitura},#{simbolo_leitura})->(#{simbolo_escrita},#{estado_destino},#{movimento})")

        # Reinicia as variáveis de leitura
        estado_leitura = 'f'
        simbolo_leitura = ''
        estado_destino = ''
        simbolo_escrita = ''

        operar('f', :q1, :D)

      # Leitura do final das transições
      in [:q8, '$']
        leitura = [estado_leitura, simbolo_leitura]
        transicoes[leitura] = [simbolo_escrita, estado_destino, movimento]
        puts("Transição lida: (#{estado_leitura},#{simbolo_leitura})->(#{simbolo_escrita},#{estado_destino},#{movimento})")
        puts("==========================================\n\n")

        puts('=========== Leitura dos símbolos: ===========')

        operar('$', :q20, :D)
        simbolo_leitura = ''

      # Leitura dos símbolos da fita
      in [:q20, '_']
        simbolo_leitura << '_'
        operar('_', :q21, :D)
      in [:q20, 's']
        simbolo_leitura << 's'
        operar('s', :q21, :D)
      in [:q21, 'c']
        simbolo_leitura << 'c'
        operar('c', :q21, :D)

      in [:q21, 's']
        @fita_cadeia << simbolo_leitura
        simbolo_leitura = 's'
        operar('s', :q21, :D)

      in [:q21, '_']
        @fita_cadeia << simbolo_leitura
        simbolo_leitura = '_'
        operar('_', :q21, :D)

      # Final da leitura dos símbolos
      in [:q21, ' ']
        @fita_cadeia << simbolo_leitura
        puts("=========== Fita de símbolos: ===========\n")
        print(@fita_cadeia)

        return submaquina(transicoes)
      else
        puts "(#{estado_leitura},#{simbolo_leitura}) = (#{estado_destino},#{simbolo_escrita},#{movimento})"
        return false
      end
    end
  end

  # Função que executa a submáquina com as transições lidas
  def submaquina(transicoes)
    estado_mt = 'fa'
    @cursor_leitura = 0

    while true
      simbolo_leitura = @fita_cadeia[@cursor_leitura]
      leitura = [estado_mt, simbolo_leitura]
      puts "(#{estado_mt}, #{simbolo_leitura})"
      resultado = transicoes[leitura]

      if resultado.nil?
        puts "\n=========================================="
        puts 'Finalizando a leitura na máquina principal'
        puts "Estado final da máquina: #{estado_mt}"
        puts "==========================================\n\n"
        return false
      end

      simbolo_escrita = resultado[0]
      estado_destino = resultado[1]
      movimento = resultado[2]
      puts "-> (#{estado_destino},#{simbolo_escrita},#{movimento})"

      estado_mt = estado_destino
      @fita_cadeia[@cursor_leitura] = simbolo_escrita

      if estado_mt.start_with?('fb')
        puts "\n=========================================="
        puts 'Finalizando a leitura na máquina principal'
        puts "Estado final da máquina: #{estado_mt}"
        puts "==========================================\n\n"
        return true
      end

      if movimento == :D
        @cursor_leitura += 1
      else
        @cursor_leitura -= 1
      end
    end
  end

  # Função que realiza operações na fita
  def operar(escrever, estado, movimento = :D)
    @fita[@cursor] = escrever
    @estado = estado
    @cursor += (movimento == :D) ? 1 : -1
  end

  def fita_com_marca
    fita_dup = @fita.dup
    fita_dup.insert(@cursor, "[")
    fita_dup.insert(@cursor + 1, "]")
    fita_dup
  end

  def fita
    @fita_cadeia
  end

  attr_reader :cursor
end
