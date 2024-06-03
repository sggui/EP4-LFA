module MtMultiplicacao
  ### Estados não finais
  q0 = 'fa'           # Estado inicial
  q1 = 'faa'          # Estado de transição
  q2 = 'faaa'         # Outro estado de transição
  q3 = 'faaaa'        # Outro estado de transição
  q4 = 'faaaaa'       # Outro estado de transição
  q5 = 'faaaaaa'      # Outro estado de transição
  q6 = 'faaaaaaa'     # Outro estado de transição
  q7 = 'faaaaaaaa'    # Outro estado de transição
  q8 = 'faaaaaaaaa'   # Outro estado de transição

  ### Estado final
  q9 = 'fbbbbbbbbbb'  # Estado de aceitação

  ### Símbolo em branco
  @br = '_'

  ### Elementos do alfabeto
  @a = 'sc'           # Símbolo 'a'
  @b = 'scc'          # Símbolo 'b'
  @c = 'sccc'         # Símbolo 'c'
  @d = 'scccc'        # Símbolo 'd'

  ### Movimentação do cursor
  left = 'e'          # Esquerda
  right = 'd'         # Direita

  ### Transições da Máquina de Turing para multiplicação
  @transition1 = "#{q0}#{@a}#{q1}#{@br}#{right}"    # (q0, a) -> (q1, _, D)
  @transition2 = "#{q1}#{@a}#{q1}#{@a}#{right}"     # (q1, a) -> (q1, a, D)
  @transition3 = "#{q1}#{@b}#{q2}#{@d}#{right}"     # (q1, b) -> (q2, d, D)
  @transition4 = "#{q2}#{@b}#{q2}#{@b}#{right}"     # (q2, b) -> (q2, b, D)
  @transition5 = "#{q2}#{@c}#{q2}#{@c}#{right}"     # (q2, c) -> (q2, c, D)
  @transition6 = "#{q2}#{@br}#{q3}#{@c}#{left}"     # (q2, _) -> (q3, c, E)
  @transition7 = "#{q3}#{@c}#{q3}#{@c}#{left}"      # (q3, c) -> (q3, c, E)
  @transition8 = "#{q3}#{@b}#{q4}#{@d}#{right}"     # (q3, b) -> (q4, d, D)
  @transition9 = "#{q4}#{@c}#{q4}#{@c}#{right}"     # (q4, c) -> (q4, c, D)
  @transition10 = "#{q4}#{@d}#{q4}#{@d}#{right}"    # (q4, d) -> (q4, d, D)
  @transition11 = "#{q4}#{@br}#{q5}#{@c}#{left}"    # (q4, _) -> (q5, c, E)
  @transition12 = "#{q5}#{@c}#{q5}#{@c}#{left}"     # (q5, c) -> (q5, c, E)
  @transition13 = "#{q5}#{@d}#{q5}#{@d}#{left}"     # (q5, d) -> (q5, d, E)
  @transition14 = "#{q5}#{@b}#{q4}#{@d}#{right}"    # (q5, b) -> (q4, d, D)
  @transition15 = "#{q5}#{@br}#{q8}#{@br}#{right}"  # (q5, _) -> (q8, _, D)
  @transition16 = "#{q5}#{@a}#{q6}#{@a}#{right}"    # (q5, a) -> (q6, a, D)
  @transition17 = "#{q6}#{@d}#{q6}#{@b}#{right}"    # (q6, d) -> (q6, b, D)
  @transition18 = "#{q6}#{@c}#{q6}#{@c}#{right}"    # (q6, c) -> (q6, c, D)
  @transition19 = "#{q6}#{@br}#{q7}#{@br}#{left}"   # (q6, _) -> (q7, _, E)
  @transition20 = "#{q7}#{@c}#{q7}#{@c}#{left}"     # (q7, c) -> (q7, c, E)
  @transition21 = "#{q7}#{@b}#{q7}#{@b}#{left}"     # (q7, b) -> (q7, b, E)
  @transition22 = "#{q7}#{@a}#{q7}#{@a}#{left}"     # (q7, a) -> (q7, a, E)
  @transition23 = "#{q7}#{@br}#{q0}#{@br}#{right}"  # (q7, _) -> (q0, _, D)
  @transition24 = "#{q8}#{@d}#{q8}#{@br}#{right}"   # (q8, d) -> (q8, _, D)
  @transition25 = "#{q8}#{@c}#{q9}#{@c}#{right}"    # (q8, c) -> (q9, c, D)

  ### Método para concatenar todas as transições em uma única string
  def self.linker
    "#{@transition1}#{@transition2}#{@transition3}#{@transition4}#{@transition5}#{@transition6}#{@transition7}#{@transition8}#{@transition9}#{@transition10}#{@transition11}#{@transition12}#{@transition13}#{@transition14}#{@transition15}#{@transition16}#{@transition17}#{@transition18}#{@transition19}#{@transition20}#{@transition21}#{@transition22}#{@transition23}#{@transition24}#{@transition25}"
  end

  ### Método para retornar a codificação da cadeia inicial aaabbb
  def self.codificacao_palavra
    "#{@a}#{@a}#{@a}#{@b}#{@b}#{@b}"
  end
end
