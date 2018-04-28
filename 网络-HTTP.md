##HTTP

###Request 部分
|Request
|-------
|Request Line
|换行（CRLF）
|Request Header
|换行（CRLF）
|Request Body


###一、Request Line

`Request Line = Method SP Request-URI SP HTTP-Version CRLF`

* Method就是我们平常谈论最多的 POST 和 GET 所处的部分

* SP 是个分隔符，对应 ASCII码中的空格

* Request-URI，一种是完整的 absoluteURI，包含 Schema和 Host，另一种是 abs_path，并没有包含schema和 Host 部分，Host 部分被移交到了 Header 中。

* HTTP-Version：HTTP/1.1，代表当前使用的版本

`GET 空格 /res/static/thirdparty/connect.jpg?t=1480992153.564331 空格 HTTP/1.1 CRLF`

###二、Request Header
Header 本质上是一些文本键值对，Key：空格 Value CRLF

###三、Request Body
Body 里面包含请求的实际数据

Method=GET，body 体是为空的
Method=POST，body 体一般不为空，实际业务数据在 body 中

###Reponse部分

|Reponse
|-------
|Status Line
|换行（CRLF）
|Reponse Header
|换行（CRLF）
|Reponse Body

###Status Line
`Status-Line = HTTP-Version SP Status-Code SP Reason-Phrase CRLF`
###Header 解析
###Body 解析