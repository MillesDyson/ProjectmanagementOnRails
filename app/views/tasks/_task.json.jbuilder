json.extract! task, :id, :name, :description, :start_date, :end_date, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
