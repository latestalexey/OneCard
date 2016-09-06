﻿Функция УстановитьПараметрыШаблона(par, valuePar) Экспорт
	index = ПолучитьОбщийМакет("index").ПолучитьТекст();
	index = СтрЗаменить(index, par, valuePar);	
	Возврат index;
КонецФункции

Функция ПолучитьШаблонСтраницы(page, options=Неопределено, options_value=Неопределено) Экспорт

	page = ПолучитьОбщийМакет(page).ПолучитьТекст();
	
	Если НЕ options = Неопределено Тогда 
		Для Каждого opt Из options Цикл
			value = options_value.Получить(opt);
			page  = СтрЗаменить(page, opt, value);	
		КонецЦикла;
	КонецЕсли;
	
	Возврат page;

КонецФункции // ПолучитьШаблонСтраницы()

// Функциявозвращает раскодированную строку
Функция РаскодироватьСтрокуЭкспорта(закодСтрока) Экспорт 

	//application/x-www-form-urlencoded
	//Вместо пробелов ставится +, символы вроде русских букв кодируются их шестнадцатеричными значениями		
	закодСтрока = РаскодироватьСтроку(закодСтрока, СпособКодированияСтроки.КодировкаURL);
	закодСтрока = СтрЗаменить(закодСтрока, "+", " ");
	Возврат закодСтрока;
	
КонецФункции // РаскодироватьСтрокуЭкспорта()


// Кодировка application/x-www-form-urlencoded
Функция ПолучитьПараметры(Тело) Экспорт
	
	Результат = Новый Соответствие;
	
	ПарметрыЗначения = ОбщегоНазначенияСервер.РазложитьСтрокуВМассивПодстрок(Тело,"&");
	Для Каждого Пар Из ПарметрыЗначения Цикл
		мПар = ОбщегоНазначенияСервер.РазложитьСтрокуВМассивПодстрок(Пар, "=");
		Если мПар.Количество()>1 Тогда
			Результат.Вставить(мПар[0],мПар[1]);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция РазложитьСтрокуВМассивПодстрок(Знач Строка, Знач Разделитель = ",", Знач ПропускатьПустыеСтроки = Неопределено) Экспорт  
	
	Результат = Новый Массив;
	
	Если ПропускатьПустыеСтроки = Неопределено Тогда
		ПропускатьПустыеСтроки = ?(Разделитель = " ", Истина, Ложь);
		Если ПустаяСтрока(Строка) Тогда 
			Если Разделитель = " " Тогда
				Результат.Добавить("");
			КонецЕсли;
			Возврат Результат;
		КонецЕсли;
	КонецЕсли;

	Позиция = Найти(Строка, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(Строка, Позиция - 1);
		Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Подстрока) Тогда
			Результат.Добавить(Подстрока);
		КонецЕсли;
		Строка = Сред(Строка, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(Строка, Разделитель);
	КонецЦикла;
	
	Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Строка) Тогда
		Результат.Добавить(Строка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция СоздатьЗаявкуПолязователя(мыло, коммент) Экспорт
	НовыйЭлемент = Справочники.ЗаявкиПользователей.СоздатьЭлемент();
	НовыйЭлемент.Email = мыло;
	НовыйЭлемент.Сообщение = коммент;
	НовыйЭлемент.Записать();
	Возврат Истина;
КонецФункции
