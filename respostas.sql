#1 - Você é solicitado a recuperar o nome completo (FirstName e LastName) de todos os funcionários que foram contratados no ano de 2023.
select FirstName, LastName
from Employees
where year(HireDate) = 2023;

#2 - Calcule a média de salário por departamento. Liste o nome do departamento e a média de salário, classificados em ordem decrescente pela média de salário.
select d.DepartmentName, avg(e.Salary) as AvgSalary
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName
order by AvgSalary desc;

#3 - Escreva uma consulta eficiente para encontrar o funcionário mais antigo (em termos de data de contratação) em cada departamento. A consulta deve retornar o DepartmentID, o EmployeeID e a data de contratação do funcionário mais antigo em cada departamento.
select e.DepartmentID, e.EmployeeID, e.HireDate
from Employees e
inner join (
    select DepartmentID, MIN(HireDate) as MinHireDate
    from Employees
    group by DepartmentID
) em on e.DepartmentID = em.DepartmentID and e.HireDate = em.MinHireDate;

#4 - O departamento de "Recursos Humanos" tem um grande número de funcionários. Escreva uma consulta eficiente para contar o número total de funcionários neste departamento.
select count(*) as TotalEmployees
from Employees
where DepartmentID = (
    select DepartmentID
    from Departments
    where DepartmentName = 'Recursos Humanos'
);

#5 - Uma atualização em massa deve ser realizada em todas as linhas da tabela Employees, aumentando o salário de todos os funcionários em 10%. Escreva uma consulta que execute essa atualização de forma eficiente, minimizando o impacto no desempenho do sistema.
UPDATE Employees
SET Salary = Salary * 1.10;

#6 - Recupere o nome completo (FirstName e LastName) dos funcionários, juntamente com o nome do departamento em que trabalham e o nome do projeto ao qual estão atualmente atribuídos. Além disso, inclua a data de início do projeto e a quantidade total de horas trabalhadas pelo funcionário no projeto até o momento.
select  
    e.FirstName, 
    e.LastName, 
    d.DepartmentName, 
    p.ProjectName, 
    p.StartDate, 
    SUM(a.HoursWorked) AS TotalHoursWorked
from Employees e
inner join Departments d on e.DepartmentID = d.DepartmentID
inner join Assignments a on e.EmployeeID = a.EmployeeID
inner join Projects p on a.ProjectID = p.ProjectID
group by e.FirstName, e.LastName, d.DepartmentName, p.ProjectName, p.StartDate;

#7 - Calcule a média de classificação (Rating) das revisões dos funcionários em cada departamento. Liste o nome do departamento e a média de classificação, incluindo apenas os departamentos onde a média de classificação seja maior que 3.
select 
    d.DepartmentName,
    avg(r.Rating) as AvgRating
from Departments d
join Employees e on d.DepartmentID = e.DepartmentID
join Reviews r on e.EmployeeID = r.EmployeeID
group by d.DepartmentName
having avg(r.Rating) > 3;

#8 - Recupere o nome completo (FirstName e LastName) dos funcionários que foram atribuídos a projetos com uma duração superior a 6 meses. Ordene os resultados pelo nome do projeto em ordem alfabética.
select 
    e.FirstName,
    e.LastName,
    p.ProjectName,
    datediff(p.EndDate, p.StartDate) as DurationDays
from Employees e
join Assignments a on e.EmployeeID = a.EmployeeID
join Projects p on a.ProjectID = p.ProjectID
where DATEDIFF(p.EndDate, p.StartDate) > 180
order by p.ProjectName asc;

#9 - Identifique os funcionários que trabalharam em pelo menos três projetos diferentes nos últimos 12 meses. Liste o nome completo desses funcionários e a contagem de projetos em que estiveram envolvidos.
select 
    e.FirstName, 
    e.LastName, 
    COUNT(DISTINCT a.ProjectID) AS NumProjects
from Employees e
join Assignments a ON e.EmployeeID = a.EmployeeID
join Projects p ON a.ProjectID = p.ProjectID
where a.AssignmentDate >= date_sub(now(), interval 12 month)
group by e.FirstName, e.LastName
having count(distinct a.ProjectID) >= 3;

#10 - Uma nova política salarial foi implementada, aumentando o salário de todos os funcionários em 5%, exceto aqueles que estão atribuídos a projetos com uma duração superior a 9 meses. Atualize os salários dos funcionários de acordo com essa política.
update Employees e
set Salary = 
    case
        when exists (
            select 1 
            from Assignments a 
            join Projects p on a.ProjectID = p.ProjectID
            where a.EmployeeID = e.EmployeeID
            and datediff(p.EndDate, p.StartDate) > 270 
        ) then Salary  
        else Salary * 1.05  
    end;
