## Изучение языка Sentinel

Данный язык является воплощением подхода policy as code. С помощью данного языка можно описывать программы в виде набора политик, что является достаточно хорошей альтернативой, когда требуется создать код, который был бы понятен как программистам, так и людям, не разбирающимся в программировании. Данный язык применяют при описании CI/CD процессов. Но на мой взгляд, область его применения не ограничивается только этой сферой и в своей магистерской дисертации я постораюсь применить этот язык для создания исполняемой спецификации. Но для начала было бы неплохо его изучить, чем я и собираюсь заняться, проходя описанную ниже программу:)

## 1 Ключевые концепции и инструменты.

В разделе 1 необходимо узнать о ключевых концепциях языка и о инструментах, которые необходимы для работы с данным языком.

### 1.1 Ключевые концепции

В результате изучения этой главы у меня должно быть четкое понимание того, чем является язык Sentinel, что отличает его от других языков, что означает концепция Policy as code и т. д. В результате изучения этой главы, я должен составить небольшой документ, в котором будут описаны ключевые механизмы, отличия от остальных языков, преймущества и недостатки подхода Policy as code.

Ссылки для изучения главы:
https://docs.hashicorp.com/sentinel/concepts

### 1.2 Инструменты и механизмы языка Sentinel

В процессе прохождения этой главы я должен буду опробовать транслятор языка Sentinel. Транслятор языка Sentinel имеет не так много различных конманд, так что вполне возможно изучить их все. Также необходимо разобраться в создании конфигурационного файла Sentinel. В документации языка Sentinel есть глава посвященная основам написания политик, которую как раз можно использовать для изучения инструментов и механизмов языка. Результатом изучения этой главы будет несколько файлов с описанием простейших политик, аналогичных тем, что описаны в главе документации, а также скриншоты результатов выполнения этих политик (в различных режимах, если это имеет смысл).

Ссылки для изучения главы:
https://docs.hashicorp.com/sentinel/configuration
https://docs.hashicorp.com/sentinel/commands
https://docs.hashicorp.com/sentinel/writing
https://docs.hashicorp.com/sentinel/extending (в этой главе только ознакомиться)

## 2 Изучение спецификации

Так как Sentinel довольно простой в изучении язык (что и является его преимуществом) вся его спецификация лаконично умещается на одной html странице. В результате прохождения этого раздела у меня должно сложиться общее понимание всего языка политик Sentinel. По своей сути, глава состоит из изучения спецификации и использовании ее на практике.

Ссылка для изучения раздела:
https://docs.hashicorp.com/sentinel/language/spec

### 2.1 Типы и структуры данных

В течении данной главы я буду изучать различные встроенные в Sentinel типы данных, начиная от простых чисел и строк и заканчивая более комплексными списками, словарями и т. д. В результате главы должны быть опробованы на практике все основные типы языка. Я думаю, что они будут опробованы примерно в 3-5 различных программах, которые не будут иметь конкретной цели, но с помощью которых можно будет получить представление об использовании примитивов языка Sentinel. Глава затрагивает часть спецификации от начала и до пункта Statements.

### 2.2 Выражения и встроенные функции

В этой главе мне предстоит изучить, как именно работают известные всем циклы и условия, а также какие популярные встроенные функции есть в данном языке. Еще одной темой, которую я затрону в данном пункте будет тема параметров политик. Эта глава не будет очень большой и в качетсве практики можно реализовать различные учебные алгоритмы вроде алгоритмов поиска и сортировки. Всего здесь будет 2 практические работы. Изучение основано на той же спецификации с пункта statements и до конца спецификации, исключая пункт imports.

## 3 Расширение базовых возможностей Sentinel

Эта глава посвящена созданию модулей в Sentinel, а также расширению набора встроенных функций.

### 3.1 Модули, плагины и их импорт

Как и в многих других языках, в Sentinel есть возможность заново использовать написанный код. Данная глава посвященна именно этому. Необходимо разобраться в том, как именно работают эти механизмы на примере одной практической работы, которая и будет заключаться в использовании функций посредством импортов и плагинов.

Ссылки для изучени:
https://docs.hashicorp.com/sentinel/extending

### 3.2 Расширение языка Sentinel

Язык Sentinel довольно прост, что отчасти является его достоинством, так как он требует довольно низкий порог вхождения. Однако иногда бывает довольно сложно реализовать что-либо средствами самого языка. В этом случае нам поможет возможность расширять язык Sentinel с помощью языка Go. В этой главе я должен научиться расширять язык на примере одной практической работы, которая может заключаться в создании функций сервера, к примеру. Или же практическая работа может заключаться в считывании данных из файла определенного формата.