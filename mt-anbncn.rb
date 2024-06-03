module MtAnBnCn
  # Estados codificados
  q0 = "fa"        # Estado inicial
  q1 = "faa"       # Estado de transição
  q2 = "faaa"      # Outro estado de transição
  q3 = "faaaa"     # Outro estado de transição
  q4 = "faaaaa"    # Outro estado de transição
  q5 = "faaaaaa"   # Outro estado de transição
  q6 = "faaaaaaa"  # Outro estado de transição
  q7 = "faaaaaaaa" # Outro estado de transição
  q8 = "faaaaaaaaa" # Outro estado de transição
  q9 = "faab"      # Outro estado de transição
  q_accept = "fb"  # Estado de aceitação

  # Símbolos na fita
  @a = "sc"        # Símbolo 'a'
  @x = "scc"       # Símbolo marcado 'x'
  @b = "sccc"      # Símbolo 'b'
  @y = "scccc"     # Símbolo marcado 'y'
  @c = "sccccc"    # Símbolo 'c'
  @z = "scccccc"   # Símbolo marcado 'z'
  @blank = "_"     # Símbolo em branco

  # Movimentos
  left = "e"        # Esquerda
  right = "d"       # Direita

  # Transições para a linguagem a^nb^nc^n
  @transition1 = "#{q0}#{@a}#{q1}#{@x}#{right}"      # (q0, a) -> (q1, x, D)
  @transition2 = "#{q1}#{@a}#{q1}#{@a}#{right}"      # (q1, a) -> (q1, a, D)
  @transition3 = "#{q1}#{@b}#{q2}#{@b}#{right}"      # (q1, b) -> (q2, b, D)
  @transition4 = "#{q2}#{@b}#{q2}#{@b}#{right}"      # (q2, b) -> (q2, b, D)
  @transition5 = "#{q2}#{@c}#{q3}#{@c}#{left}"       # (q2, c) -> (q3, c, E)
  @transition6 = "#{q3}#{@b}#{q3}#{@b}#{left}"       # (q3, b) -> (q3, b, E)
  @transition7 = "#{q3}#{@a}#{q3}#{@a}#{left}"       # (q3, a) -> (q3, a, E)
  @transition8 = "#{q3}#{@x}#{q0}#{@x}#{right}"      # (q3, x) -> (q0, x, D)

  @transition9 = "#{q0}#{@b}#{q4}#{@y}#{right}"      # (q0, b) -> (q4, y, D)
  @transition10 = "#{q4}#{@b}#{q4}#{@b}#{right}"     # (q4, b) -> (q4, b, D)
  @transition11 = "#{q4}#{@c}#{q5}#{@c}#{left}"      # (q4, c) -> (q5, c, E)
  @transition12 = "#{q5}#{@b}#{q5}#{@b}#{left}"      # (q5, b) -> (q5, b, E)
  @transition13 = "#{q5}#{@a}#{q5}#{@a}#{left}"      # (q5, a) -> (q5, a, E)
  @transition14 = "#{q5}#{@y}#{q0}#{@y}#{right}"     # (q5, y) -> (q0, y, D)

  @transition15 = "#{q0}#{@c}#{q6}#{@z}#{right}"     # (q0, c) -> (q6, z, D)
  @transition16 = "#{q6}#{@c}#{q6}#{@c}#{right}"     # (q6, c) -> (q6, c, D)
  @transition17 = "#{q6}#{@blank}#{q7}#{@blank}#{left}" # (q6, _) -> (q7, _, E)
  @transition18 = "#{q7}#{@c}#{q7}#{@c}#{left}"      # (q7, c) -> (q7, c, E)
  @transition19 = "#{q7}#{@b}#{q7}#{@b}#{left}"      # (q7, b) -> (q7, b, E)
  @transition20 = "#{q7}#{@a}#{q7}#{@a}#{left}"      # (q7, a) -> (q7, a, E)
  @transition21 = "#{q7}#{@z}#{q0}#{@z}#{right}"     # (q7, z) -> (q0, z, D)

  @transition22 = "#{q0}#{@blank}#{q_accept}#{@blank}#{right}" # (q0, _) -> (q_accept, _, D)

  # Método para concatenar todas as transições em uma única string
  def self.linker
    "#{@transition1}#{@transition2}#{@transition3}#{@transition4}#{@transition5}#{@transition6}#{@transition7}#{@transition8}#{@transition9}#{@transition10}#{@transition11}#{@transition12}#{@transition13}#{@transition14}#{@transition15}#{@transition16}#{@transition17}#{@transition18}#{@transition19}#{@transition20}#{@transition21}#{@transition22}"
  end

  # Método para retornar a codificação da cadeia inicial aaabbbccc
  def self.codificacao_palavra
    "#{@a}#{@a}#{@a}#{@b}#{@b}#{@b}#{@c}#{@c}#{@c}"
  end
end