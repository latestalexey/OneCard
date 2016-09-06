﻿
Функция formget(Запрос)
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.Заголовки.Вставить("Content-Type","text/html; charset=utf-8");
	
	page  = ОбщегоНазначенияСервер.ПолучитьШаблонСтраницы("feedback");
	Ответ.УстановитьТелоИзСтроки(page);
	
	Возврат Ответ;

КонецФункции

Функция formpost(Запрос)
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.Заголовки.Вставить("Content-Type","text/html; charset=utf-8");
	
	option  = ОбщегоНазначенияСервер.ПолучитьПараметры(Запрос.ПолучитьТелоКакСтроку());
	
	comment  = ОбщегоНазначенияСервер.РаскодироватьСтрокуЭкспорта(option.Получить("comment"));	
	email	 = ОбщегоНазначенияСервер.РаскодироватьСтрокуЭкспорта(option.Получить("you_email"));	
	
	Если ЗначениеЗаполнено(comment) Тогда // если коммент заполнен, тогда создаем заявку в 1с и открываем страницу successfully или error
		Если ОбщегоНазначенияСервер.СоздатьЗаявкуПолязователя(email, comment) Тогда 
			page = ОбщегоНазначенияСервер.ПолучитьШаблонСтраницы("successfully");
		Иначе	
			page = ОбщегоНазначенияСервер.ПолучитьШаблонСтраницы("error");
		КонецЕсли;
	Иначе
		page = ОбщегоНазначенияСервер.ПолучитьШаблонСтраницы("feedback");
	КонецЕсли;
	
	Ответ.УстановитьТелоИзСтроки(page);
		
	Возврат Ответ;

КонецФункции
