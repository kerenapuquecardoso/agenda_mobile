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
  '''
};


