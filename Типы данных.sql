-- ���� ������

-- ����� 7 ����� ������
-- 1. ������ �����
-- 2. ��������������� �����
-- 3. ���� � �����
-- 4. ���������� ������
-- 5. ���������� ������ � �������
-- 6. �������� ������
-- 7. ������ ���� ������

-- ������� ������������� � ���� ����������

-- BIT (�������� 0 � 1) 1 ����
DECLARE @someBit bit = 0;
PRINT @someBit;

SET @someBit = 1;
PRINT @someBit;

SET @someBit = -100;
PRINT @someBit;

SET @someBit = 100;
PRINT @someBit;

-- INTEGER (-2 ���� � +2 ����) 4 �����
DECLARE @someInt int = 125;
PRINT @someInt

SET @someInt = -50;
PRINT @someInt

-- ������ (������ ��� �����)
--SET @someInt = 2147483647 + 1
--PRINT @someInt

-- DECIMAL (NUMERIC) (�� ��������� ���������� ���� ����� ������� 0)
DECLARE @someDec decimal = 150.6;
PRINT @someDec

-- ����� 8 � 5 ����� ������� (8 - 5 = 3 �� ����� �� �������)
DECLARE @someDec2 decimal(8,5) = 123.45;
PRINT @someDec2