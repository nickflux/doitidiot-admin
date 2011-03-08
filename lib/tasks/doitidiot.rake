namespace :doitidiot do

  desc "Make the todos angry and re-order"
  task :get_angry => :environment do
    # make todos angry
    (1..5).each do |level|
      todos = Todo.alive.where(:created_at.gt => level.week.ago.strftime("%Y-%m-%d"), :created_at.lt => level.week.ago.strftime("%Y-%m-%d 23:59:59"))
      todos.each do |todo|
        todo.anger_level  = level + 1
        todo.save
      end
    end

    # go through users and bump up angry todos
    User.all.each do |user|
      todo_count  = user.todos.count
      base_bump   = 20
      # start with newest, least angry todos so oldest and angriest go last
      todos       = user.todos.alive
      todos_array = todos.map{|t| {:id => t.id, :ordinal => t.ordinal, :created_at => t.created_at, :anger_level => t.anger_level}}
      todos_array.each_with_index do |todo, index|
        
        next if todo[:anger_level] == 1
        percent_bump  =  ((todo[:anger_level] - 1) * base_bump) / 100.00
        todo_bump     = todo_count * percent_bump 
        # find new ordinal
        new_ordinal                   = todo[:ordinal] - todo_bump.round < 1 ? 1 : todo[:ordinal] - todo_bump.round
        todos_array[index][:ordinal]  = new_ordinal
      end
      # sort order: ordinal, created_at, anger_level
      todos_array.sort! do |a,b|
        if a[:ordinal] == b[:ordinal]
          if a[:created_at] == b[:created_at]
            a[:anger_level] <=> b[:anger_level]
          else
            a[:created_at] <=> b[:created_at]
          end
        else
          a[:ordinal] <=> b[:ordinal]
        end
      end
      # now update todos
      todos_array.each_with_index do |todo, index|
        Todo.find(todo[:id]).update_attributes(:ordinal => index + 1)
      end

    end
  end
  
  desc "Send out daily to do emails"
  task :daily_emails => :environment do

    # go through users and send emails
    User.all.each do |user|
      TodoMailer.daily_todos(user).deliver
    end
  end
  
end
