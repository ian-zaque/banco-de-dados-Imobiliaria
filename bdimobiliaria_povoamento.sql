-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Mar 22, 2020 at 04:04 AM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bdimobiliaria`
--

-- --------------------------------------------------------

--
-- Table structure for table `apartamento`
--

CREATE TABLE `apartamento` (
  `andar` int(10) UNSIGNED NOT NULL,
  `valor_condominio` double UNSIGNED NOT NULL,
  `has_portaria` tinyint(4) NOT NULL,
  `id_apartamento` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `bairro`
--

CREATE TABLE `bairro` (
  `ID` int(10) UNSIGNED NOT NULL,
  `nome` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bairro`
--

INSERT INTO `bairro` (`ID`, `nome`) VALUES
(3, 'Aviário'),
(4, 'Feira VI'),
(1, 'Parque IPÊ'),
(2, 'Queimadinha');

-- --------------------------------------------------------

--
-- Table structure for table `cargo`
--

CREATE TABLE `cargo` (
  `ID` int(10) UNSIGNED NOT NULL,
  `nome` varchar(30) NOT NULL,
  `salario_base` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cargo`
--

INSERT INTO `cargo` (`ID`, `nome`, `salario_base`) VALUES
(1, 'Corretor', 1000),
(2, 'gerente', 5000),
(3, 'sub-gerente', 3000);

-- --------------------------------------------------------

--
-- Table structure for table `casa`
--

CREATE TABLE `casa` (
  `qntd_quarto` int(10) UNSIGNED NOT NULL,
  `qndtd_suite` int(10) UNSIGNED NOT NULL,
  `qntd_sala_estar` int(10) UNSIGNED NOT NULL,
  `qntd_sala_jantar` int(10) UNSIGNED NOT NULL,
  `nmro_vagas` int(10) UNSIGNED NOT NULL,
  `has_armario_embutido` tinyint(4) NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `id_casa` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cliente_propietario`
--

CREATE TABLE `cliente_propietario` (
  `profissao` varchar(30) NOT NULL,
  `id_pessoa` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cliente_propietario`
--

INSERT INTO `cliente_propietario` (`profissao`, `id_pessoa`) VALUES
('carpinteiro', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cliente_usuario`
--

CREATE TABLE `cliente_usuario` (
  `fiador1` varchar(30) NOT NULL,
  `indicacao1` varchar(30) NOT NULL,
  `indicacao2` varchar(30) NOT NULL,
  `indicacao3` varchar(30) DEFAULT NULL,
  `id_pessoa` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cliente_usuario`
--

INSERT INTO `cliente_usuario` (`fiador1`, `indicacao1`, `indicacao2`, `indicacao3`, `id_pessoa`) VALUES
('1', 'Flávio Augusto', 'José Kepler', 'Armando Cerqueira', 2);

-- --------------------------------------------------------

--
-- Table structure for table `contrato`
--

CREATE TABLE `contrato` (
  `ID` int(10) UNSIGNED NOT NULL,
  `comissao_imobiliaria` double UNSIGNED NOT NULL,
  `id_transacao` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `endereco`
--

CREATE TABLE `endereco` (
  `ID` int(10) UNSIGNED NOT NULL,
  `rua` varchar(30) NOT NULL,
  `numero_casa` int(10) UNSIGNED NOT NULL,
  `CEP` int(10) UNSIGNED NOT NULL,
  `complemento` varchar(80) NOT NULL,
  `id_bairro` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `endereco`
--

INSERT INTO `endereco` (`ID`, `rua`, `numero_casa`, `CEP`, `complemento`, `id_bairro`) VALUES
(1, 'Rua A', 100, 4405456, 'Perto do posto Ipiranga', 1),
(2, 'Rua B', 200, 4405457, 'Perto do posto Texaco', 2),
(3, 'Rua C', 300, 4405458, 'Em frente a casa roxa', 4),
(4, 'Rua D', 400, 4405457, 'Próximo a policlínica', 3);

-- --------------------------------------------------------

--
-- Table structure for table `fotos`
--

CREATE TABLE `fotos` (
  `ID` int(10) UNSIGNED NOT NULL,
  `foto1` tinyblob NOT NULL,
  `foto2` tinyblob NOT NULL,
  `foto3` tinyblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `funcionario`
--

CREATE TABLE `funcionario` (
  `id_cargo` int(10) UNSIGNED NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `senha` varchar(128) NOT NULL,
  `data_ingresso` date NOT NULL,
  `id_pessoa` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `funcionario`
--

INSERT INTO `funcionario` (`id_cargo`, `usuario`, `senha`, `data_ingresso`, `id_pessoa`) VALUES
(1, 'funcionario', 'funcionariosenha', '2020-03-01', 3);

-- --------------------------------------------------------

--
-- Table structure for table `imovel`
--

CREATE TABLE `imovel` (
  `ID` int(10) UNSIGNED NOT NULL,
  `id_endereco` int(10) UNSIGNED NOT NULL,
  `data_construcao` date NOT NULL,
  `data_alugado_vendido` date NOT NULL,
  `data_postagem` date NOT NULL,
  `id_fotos` int(10) UNSIGNED NOT NULL,
  `status` enum('Disponível para Venda','Disponível para Aluguel','Vendido','Alugado','Indisponível') NOT NULL,
  `area` double UNSIGNED NOT NULL,
  `categoria` enum('Casa','Apartamento','Sala Comercial','Terreno') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pagamento`
--

CREATE TABLE `pagamento` (
  `ID` int(10) UNSIGNED NOT NULL,
  `valor` double UNSIGNED NOT NULL,
  `forma_pagamento` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pagamento`
--

INSERT INTO `pagamento` (`ID`, `valor`, `forma_pagamento`) VALUES
(1, 100, 'boleto'),
(2, 150, 'cartao');

-- --------------------------------------------------------

--
-- Table structure for table `pessoa`
--

CREATE TABLE `pessoa` (
  `ID` int(10) UNSIGNED NOT NULL,
  `nome` varchar(20) NOT NULL,
  `sobrenome` varchar(45) NOT NULL,
  `CPF` varchar(11) NOT NULL,
  `id_endereco` int(10) UNSIGNED NOT NULL,
  `email` varchar(45) NOT NULL,
  `estado_civil` varchar(15) NOT NULL,
  `sexo` enum('F','M') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pessoa`
--

INSERT INTO `pessoa` (`ID`, `nome`, `sobrenome`, `CPF`, `id_endereco`, `email`, `estado_civil`, `sexo`) VALUES
(1, 'Francisco Hugo', 'Rezende', '92546317599', 1, 'franciscohr@maquinas.com.br', 'solteiro', 'M'),
(2, 'Gabriel ', 'Medina', '92546317598', 2, 'medina@email.com', 'casado', 'M'),
(3, 'Fátima ', 'Bernardes', '92546317597', 3, 'fbernardes@eumail.com', 'casada', 'F'),
(4, 'Ruan', 'Portos', '92546317592', 4, 'portos@ail.com', 'solteiro', 'M');

-- --------------------------------------------------------

--
-- Table structure for table `relacao_cliente_usuario_imovel`
--

CREATE TABLE `relacao_cliente_usuario_imovel` (
  `ID` int(10) UNSIGNED NOT NULL,
  `id_imovel_usuario` int(10) UNSIGNED NOT NULL,
  `id_cliente_usuario` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `relacao_proprietario_imovel`
--

CREATE TABLE `relacao_proprietario_imovel` (
  `ID` int(10) UNSIGNED NOT NULL,
  `id_imovel` int(10) UNSIGNED NOT NULL,
  `id_proprietario` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sala_comercial`
--

CREATE TABLE `sala_comercial` (
  `qntd_banheiro` int(10) UNSIGNED NOT NULL,
  `qntd_comodo` int(10) UNSIGNED NOT NULL,
  `id_sala_comercial` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tel_email`
--

CREATE TABLE `tel_email` (
  `ID` int(10) UNSIGNED NOT NULL,
  `id_pessoa` int(10) UNSIGNED NOT NULL,
  `telefone_contato` varchar(15) NOT NULL,
  `telefone_celular` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tel_email`
--

INSERT INTO `tel_email` (`ID`, `id_pessoa`, `telefone_contato`, `telefone_celular`, `email`) VALUES
(1, 1, '557552366587', '557511254785', 'francis@macio.com'),
(2, 2, '557588596584', '557511245698', 'medina@life.com'),
(3, 3, '557599984572', '557566635289', 'fbernardes@something.com'),
(4, 4, '557588845724', '557599986523', 'ruan@algo.com');

-- --------------------------------------------------------

--
-- Table structure for table `terreno`
--

CREATE TABLE `terreno` (
  `largura` double UNSIGNED NOT NULL,
  `comprimento` double UNSIGNED NOT NULL,
  `tipo_inclinacao` enum('Aclive','Declive','Sem Inclinação') DEFAULT NULL,
  `id_terreno` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `transacao`
--

CREATE TABLE `transacao` (
  `ID` int(10) UNSIGNED NOT NULL,
  `id_rel_clienteUsuario_imovel` int(10) UNSIGNED NOT NULL,
  `id_func_responsavel` int(10) UNSIGNED NOT NULL,
  `data_transacao` date NOT NULL,
  `comissao_func` double UNSIGNED NOT NULL,
  `id_pagamento` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apartamento`
--
ALTER TABLE `apartamento`
  ADD PRIMARY KEY (`id_apartamento`);

--
-- Indexes for table `bairro`
--
ALTER TABLE `bairro`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD UNIQUE KEY `nome_UNIQUE` (`nome`);

--
-- Indexes for table `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD UNIQUE KEY `nome_UNIQUE` (`nome`);

--
-- Indexes for table `casa`
--
ALTER TABLE `casa`
  ADD PRIMARY KEY (`id_casa`);

--
-- Indexes for table `cliente_propietario`
--
ALTER TABLE `cliente_propietario`
  ADD PRIMARY KEY (`id_pessoa`);

--
-- Indexes for table `cliente_usuario`
--
ALTER TABLE `cliente_usuario`
  ADD PRIMARY KEY (`id_pessoa`);

--
-- Indexes for table `contrato`
--
ALTER TABLE `contrato`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD UNIQUE KEY `id_transacao_UNIQUE` (`id_transacao`);

--
-- Indexes for table `endereco`
--
ALTER TABLE `endereco`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD UNIQUE KEY `id_bairro_UNIQUE` (`id_bairro`),
  ADD UNIQUE KEY `numero_casa_UNIQUE` (`numero_casa`);

--
-- Indexes for table `fotos`
--
ALTER TABLE `fotos`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`);

--
-- Indexes for table `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`id_pessoa`),
  ADD UNIQUE KEY `usuario_UNIQUE` (`usuario`),
  ADD KEY `id_cargo_idx` (`id_cargo`);

--
-- Indexes for table `imovel`
--
ALTER TABLE `imovel`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD UNIQUE KEY `endereco_UNIQUE` (`id_endereco`),
  ADD UNIQUE KEY `id_fotos_UNIQUE` (`id_fotos`);

--
-- Indexes for table `pagamento`
--
ALTER TABLE `pagamento`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`);

--
-- Indexes for table `pessoa`
--
ALTER TABLE `pessoa`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD UNIQUE KEY `CPF_UNIQUE` (`CPF`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD KEY `id_endereco_idx` (`id_endereco`);

--
-- Indexes for table `relacao_cliente_usuario_imovel`
--
ALTER TABLE `relacao_cliente_usuario_imovel`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD KEY `id_imovel_idx` (`id_imovel_usuario`),
  ADD KEY `id_cliente_usuario_idx` (`id_cliente_usuario`);

--
-- Indexes for table `relacao_proprietario_imovel`
--
ALTER TABLE `relacao_proprietario_imovel`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD KEY `id_imovel_idx` (`id_imovel`),
  ADD KEY `id_proprietario_idx` (`id_proprietario`);

--
-- Indexes for table `sala_comercial`
--
ALTER TABLE `sala_comercial`
  ADD PRIMARY KEY (`id_sala_comercial`);

--
-- Indexes for table `tel_email`
--
ALTER TABLE `tel_email`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD UNIQUE KEY `id_pessoa_UNIQUE` (`id_pessoa`),
  ADD UNIQUE KEY `telefone_contato_UNIQUE` (`telefone_contato`),
  ADD UNIQUE KEY `telefone_celular_UNIQUE` (`telefone_celular`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `terreno`
--
ALTER TABLE `terreno`
  ADD PRIMARY KEY (`id_terreno`);

--
-- Indexes for table `transacao`
--
ALTER TABLE `transacao`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD KEY `id_pagamento_idx` (`id_pagamento`),
  ADD KEY `id_func_responsavel_idx` (`id_func_responsavel`),
  ADD KEY `id_rel_usuario_imovel_idx` (`id_rel_clienteUsuario_imovel`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bairro`
--
ALTER TABLE `bairro`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cargo`
--
ALTER TABLE `cargo`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `contrato`
--
ALTER TABLE `contrato`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `endereco`
--
ALTER TABLE `endereco`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `fotos`
--
ALTER TABLE `fotos`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `imovel`
--
ALTER TABLE `imovel`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pagamento`
--
ALTER TABLE `pagamento`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pessoa`
--
ALTER TABLE `pessoa`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `relacao_cliente_usuario_imovel`
--
ALTER TABLE `relacao_cliente_usuario_imovel`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `relacao_proprietario_imovel`
--
ALTER TABLE `relacao_proprietario_imovel`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tel_email`
--
ALTER TABLE `tel_email`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `apartamento`
--
ALTER TABLE `apartamento`
  ADD CONSTRAINT `fk_apartamento_casa1` FOREIGN KEY (`id_apartamento`) REFERENCES `casa` (`id_casa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `casa`
--
ALTER TABLE `casa`
  ADD CONSTRAINT `fk_casa_imovel1` FOREIGN KEY (`id_casa`) REFERENCES `imovel` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cliente_propietario`
--
ALTER TABLE `cliente_propietario`
  ADD CONSTRAINT `fk_cliente_propietario_pessoa1` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cliente_usuario`
--
ALTER TABLE `cliente_usuario`
  ADD CONSTRAINT `fk_cliente_usuario_pessoa1` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `contrato`
--
ALTER TABLE `contrato`
  ADD CONSTRAINT `id_transacao` FOREIGN KEY (`id_transacao`) REFERENCES `transacao` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `endereco`
--
ALTER TABLE `endereco`
  ADD CONSTRAINT `id_bairro` FOREIGN KEY (`id_bairro`) REFERENCES `bairro` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `funcionario`
--
ALTER TABLE `funcionario`
  ADD CONSTRAINT `fk_funcionario_pessoa1` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_cargo` FOREIGN KEY (`id_cargo`) REFERENCES `cargo` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `imovel`
--
ALTER TABLE `imovel`
  ADD CONSTRAINT `id_endereço` FOREIGN KEY (`id_endereco`) REFERENCES `endereco` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_fotos` FOREIGN KEY (`id_fotos`) REFERENCES `fotos` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pessoa`
--
ALTER TABLE `pessoa`
  ADD CONSTRAINT `id_endereco` FOREIGN KEY (`id_endereco`) REFERENCES `endereco` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `relacao_cliente_usuario_imovel`
--
ALTER TABLE `relacao_cliente_usuario_imovel`
  ADD CONSTRAINT `id_cliente_usuario` FOREIGN KEY (`id_cliente_usuario`) REFERENCES `cliente_usuario` (`id_pessoa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_imovel_usuario` FOREIGN KEY (`id_imovel_usuario`) REFERENCES `imovel` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `relacao_proprietario_imovel`
--
ALTER TABLE `relacao_proprietario_imovel`
  ADD CONSTRAINT `id_imovel` FOREIGN KEY (`id_imovel`) REFERENCES `imovel` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_proprietario` FOREIGN KEY (`id_proprietario`) REFERENCES `cliente_propietario` (`id_pessoa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sala_comercial`
--
ALTER TABLE `sala_comercial`
  ADD CONSTRAINT `fk_sala_comercial_imovel1` FOREIGN KEY (`id_sala_comercial`) REFERENCES `imovel` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tel_email`
--
ALTER TABLE `tel_email`
  ADD CONSTRAINT `id_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `terreno`
--
ALTER TABLE `terreno`
  ADD CONSTRAINT `fk_terreno_imovel1` FOREIGN KEY (`id_terreno`) REFERENCES `imovel` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `transacao`
--
ALTER TABLE `transacao`
  ADD CONSTRAINT `id_func_responsavel` FOREIGN KEY (`id_func_responsavel`) REFERENCES `funcionario` (`id_pessoa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_pagamento` FOREIGN KEY (`id_pagamento`) REFERENCES `pagamento` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_rel_usuario_imovel` FOREIGN KEY (`id_rel_clienteUsuario_imovel`) REFERENCES `relacao_cliente_usuario_imovel` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
