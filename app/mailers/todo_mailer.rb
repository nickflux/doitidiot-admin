class TodoMailer < ActionMailer::Base
  
  default :from => "no-one-reads-this@doitidiot.com"

  def daily_todos(user)
    @user   = user
    @todos  = user.todos.alive.asc(:ordinal)
    mail(:to => "#{@user.email} <#{@user.email}>", :subject => "Why haven't you done this yet? Do it, idiot.")
  end

end
