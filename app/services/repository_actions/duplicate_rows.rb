# frozen_string_literal: true

module RepositoryActions
  class DuplicateRows
    attr_reader :number_of_duplicated_items
    def initialize(user, repository, rows_ids = [])
      @user                       = user
      @repository                 = repository
      @rows_to_duplicate          = sanitize_rows_to_duplicate(rows_ids)
      @number_of_duplicated_items = 0
    end

    def call
      @rows_to_duplicate.each do |row_id|
        duplicate_row(row_id)
      end
    end

    private

    def sanitize_rows_to_duplicate(rows_ids)
      process_ids = rows_ids.map(&:to_i).uniq
      @repository.repository_rows.where(id: process_ids).pluck(:id)
    end

    def duplicate_row(id)
      row = RepositoryRow.find_by_id(id)
      new_row = RepositoryRow.new(
        row.attributes.merge(new_row_attributes(row.name, @user.id))
      )

      if new_row.save
        @number_of_duplicated_items += 1
        row.repository_cells.each do |cell|
          duplicate_repository_cell(cell, new_row)
        end

        Activities::CreateActivityService
          .call(activity_type: :copy_inventory_item,
                owner: @user,
                subject: @repository,
                team: @repository.team,
                message_items: { repository_row_new: new_row.id, repository_row_original: row.id })
      end
    end

    def new_row_attributes(name, user_id)
      timestamp = DateTime.now
      { id: nil,
        name: "#{name} (1)",
        created_by_id: user_id,
        created_at: timestamp,
        updated_at: timestamp }
    end

    def duplicate_repository_cell(cell, new_row)
      RepositoryActions::DuplicateCell.new(
        cell, new_row, @user, @repository.team
      ).call
    end
  end
end
