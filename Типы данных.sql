-- Типы данных

-- Всего 7 типов данных
-- 1. Точные числа
-- 2. Приблизительные числа
-- 3. Дата и время
-- 4. Символьные строки
-- 5. Символьные строки в Юникоде
-- 6. Двоичные данные
-- 7. Прочие типы данных

-- Примеры использования в виде переменных

-- BIT (значения 0 и 1) 1 байт
DECLARE @someBit bit = 0;
PRINT @someBit;

SET @someBit = 1;
PRINT @someBit;

SET @someBit = -100;
PRINT @someBit;

SET @someBit = 100;
PRINT @someBit;

-- INTEGER (-2 млрд и +2 млрд) 4 байта
DECLARE @someInt int = 125;
PRINT @someInt

SET @someInt = -50;
PRINT @someInt

-- Ошибка (больше чем можно)
--SET @someInt = 2147483647 + 1
--PRINT @someInt

-- DECIMAL (NUMERIC) (по умолчанию количество цифр после запятой 0)
DECLARE @someDec decimal = 150.6;
PRINT @someDec

-- Всего 8 и 5 после запятой (8 - 5 = 3 на число до запятой)
DECLARE @someDec2 decimal(8,5) = 123.45;
PRINT @someDec2