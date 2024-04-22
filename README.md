# Resposta do teste de SQL

Este repositório contém as respostas para o teste de SQL da vaga, incluindo consultas SQL para as questões propostas.

## Estrutura do Repositório
- `respostas.sql`: Arquivo contendo as consultas SQL para as questões do teste.
- `README.md`: Este arquivo com informações sobre o repositório.

##Observações
- As consultas foram elaboradas utilizando como base a seguinte esquema de banco de dados:

    CREATE TABLE Employees (
      EmployeeID INT PRIMARY KEY,
      FirstName VARCHAR(50),
      LastName VARCHAR(50),
      DepartmentID INT,
      Salary DECIMAL(10, 2),
      HireDate DATE
  );
  
  CREATE TABLE Departments (
      DepartmentID INT PRIMARY KEY,
      DepartmentName VARCHAR(50)
  );
  
  CREATE TABLE Projects (
      ProjectID INT PRIMARY KEY,
      ProjectName VARCHAR(100),
      DepartmentID INT,
      StartDate DATE,
      EndDate DATE
  );
  
  CREATE TABLE Assignments (
      AssignmentID INT PRIMARY KEY,
      EmployeeID INT,
      ProjectID INT,
      AssignmentDate DATE,
      HoursWorked DECIMAL(5, 2)
  );

CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY,
    EmployeeID INT,
    ReviewDate DATE,
    Rating INT
); 

- Qualquer dúvida, estou à disposição!
