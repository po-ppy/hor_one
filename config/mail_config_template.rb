#_*_ coding:utf-8 _*_
Mail.defaults do
  delivery_method :smtp, address: 'smtp.163.com', port: 25, user_name: 'xxxxxxx@163.com', password: 'password', enable_ssl: false
  retriever_method :pop3, address: 'pop3.163.com',port: 995, user_name: 'xxxxxxx@163.com', password: 'password', enable_ssl: true
end
