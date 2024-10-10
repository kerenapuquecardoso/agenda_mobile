const criarTabelas = {
  '''
    CREATE TABLE estado (
      id INTEGER  PRIMARY KEY,
      estado_nome VARCHAR(200)  UNIQUE,
      sigla CHAR(2) ,
      estado_status CHAR(1) NOT NULL
    );

    CREATE TABLE cidade (
      id INTEGER  PRIMARY KEY,
      cidade_nome VARCHAR(200) ,
      cidade_status CHAR(1) NOT NULL,
      estado_id INTEGER ,  
      FOREIGN KEY (estado_id) REFERENCES estado(id) ON DELETE CASCADE
    );

    CREATE TABLE cliente (
      id INTEGER  PRIMARY KEY,
      cliente_nome VARCHAR(200),
      cpf CHAR(14)  UNIQUE,
      telefone VARCHAR(14) ,  
      rua VARCHAR(200) ,
      numero INTEGER ,
      cliente_status CHAR(1) NOT NULL,
      cidade_id INTEGER ,  
      FOREIGN KEY (cidade_id) REFERENCES cidade(id) ON DELETE CASCADE
    );
  '''
};



const inserirRegistros = {

  'INSERT INTO estado (id, estado_nome, sigla, estado_status) VALUES (1, "Paraná", "PR", \'A\' )'
  ,'INSERT INTO estado (id, estado_nome, sigla, estado_status) VALUES (2, "Acre", "AC", \'A\')'
  ,'INSERT INTO cidade (id, cidade_nome, cidade_status, estado_id) VALUES (1, "Paranavaí",  \'A\', 1)'
  ,'INSERT INTO cidade (id, cidade_nome, cidade_status, estado_id) VALUES (2, "Rio Branco", \'A\',  2)'
  ,'INSERT INTO cliente (id, cliente_nome, cpf, telefone, rua, numero, cliente_status, cidade_id) VALUES(1, "Keren Apuque", \'12399902947\', "999060526", "Carlinda D.", 123, \'A\', 1)'  

};

