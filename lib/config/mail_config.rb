#_*_ coding:utf-8 _*_
Mail.defaults do
  delivery_method :smtp, address: 'smtp.163.com', port: 25, user_name: '18821701674@163.com', password: 'hor163', enable_ssl: false
  retriever_method :pop3, address: 'pop3.163.com',port: 995, user_name: '18821701674@163.com', password: 'hor163', enable_ssl: true
end
