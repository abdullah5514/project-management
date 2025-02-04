# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :start_date
      t.string :duration

      t.timestamps
    end
  end
end
