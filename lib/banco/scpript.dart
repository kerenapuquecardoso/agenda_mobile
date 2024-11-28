const criarTabelas = {
  '''
    CREATE TABLE cliente (
      id INTEGER  PRIMARY KEY,
      cliente_nome VARCHAR(200),
      cpf CHAR(14)  UNIQUE,
      telefone VARCHAR(14) ,  
      rua VARCHAR(200) ,
      numero INTEGER ,
      cliente_status CHAR(1) NOT NULL,
      cidade_id INTEGER  
    );
  ''',
  ''' 
     CREATE TABLE funcionario (
      id INTEGER PRIMARY KEY,
      funcionario_nome VARCHAR(200),
      cpf CHAR(14) UNIQUE,
      senha VARCHAR(200),
      funcionario_status CHAR(1) NOT NULL
    );
  ''',
  '''
    CREATE TABLE locacao (
      id INTEGER PRIMARY KEY,
      cliente_id INTEGER,
      funcionario_id INTEGER,
      data_locacao DATETIME DEFAULT CURRENT_TIMESTAMP,
      data_devolucao DATETIME,
      data_retirada DATETIME,
      status CHAR(1) DEFAULT 'A',
      valor_total REAL DEFAULT 0.0,
      FOREIGN KEY (cliente_id) REFERENCES cliente(id),
      FOREIGN KEY (funcionario_id) REFERENCES funcionario(id)
    );
  '''
};


const inserirDados = {
  '''
  INSERT INTO cliente (id, cliente_nome, cpf, telefone, rua, numero, cliente_status, cidade_id) 
  VALUES (1, 'João Silva', '123.456.789-00', '(44) 99999-9999', 'Rua Principal', 123, 'A', 87650000);
  '''
};