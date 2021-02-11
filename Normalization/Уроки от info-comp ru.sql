-- ������ ����������� �����

-----------------------------------
-- ������� ����� ��
USE master
GO

CREATE DATABASE infoCompTutsDB
GO

USE infoCompTutsDB
GO

----------------------------------
-- ������� �� ��������������� �������

CREATE TABLE Employees(
	FullName varchar(max)
	,Contacts varchar(max)
)
GO

INSERT Employees VALUES
('������ �.�.', '123-456-789, 987-654-321')
,('������� �.�.', '������� ������� 555-666-777, �������� ������� 777-888-999')
,('John Smith', '123-456-789')
,('John Smith', '123-456-789')
GO

SELECT * FROM Employees
GO

----------------------------------
-- � ������� ��������� ��������
-- ���� ������������� ������ � ���� ������ �������� � ���������

-- ����� �������� � ������ ���������� ����
-- ������� �����
-- ������ ��������� ��������� �� ��������� �����, ����� ��� 1 ����� ��������
-- ��� �������� ������� � ��������� �������

DROP TABLE Employees
GO

CREATE TABLE Employees(
	FullName varchar(max)
	,Phone varchar(20)
	,PhoneType varchar(20)
)
GO

INSERT Employees VALUES
('������ �.�.', '123-456-789', NULL)
,('������ �.�.', '987-654-321', NULL)
,('������� �.�.', '123-456-789', '�������� �������')
,('������� �.�.', '123-456-789', '�������� �������')
,('John Smith', '123-456-789', NULL)
GO

SELECT * FROM Employees