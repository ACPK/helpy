require 'doorkeeper/grape/helpers'

module API
  module V1
    class Categories < Grape::API
      # helpers Doorkeeper::Grape::Helpers
      #
      # before do
      #   doorkeeper_authorize!
      # end

      include API::V1::Defaults

      resource :categories do

        # LIST ALL CATEGORIES
        desc "List all public categories", {
          entity: Entity::Category,
          notes: "Lists all active categories defined for the knowledgebase"
        }
        get "", root: :categories do
          categories = Category.active.all
          present categories, with: Entity::Category
        end

        # SHOW CATEGORY
        desc "Return a single category with listing of docs", {
          entity: Entity::Category,
          notes: "Lists all active categories defined for the knowledgebase"
        }
        params do
          requires :id, type: String, desc: "Category to list docs from"
        end
        get ":id", root: :categories do
          category = Category.where(id: permitted_params[:id]).first
          present category, with: Entity::Category, docs: true
        end

        # CREATE NEW CATEGORY
        desc "Create a new category", {
          entity: Entity::Category,
          notes: "Create a new category"
        }
        params do
          requires :name, String, desc: "The name of the category of articles"
          optional :icon, String, desc: "An icon that represents the category"
          optional :keywords, String, desc: "Keywords that will be used for internal search and SEO"
          optional :title_tag, String, desc: "An alternate title tag that will be used if provided"
          optional :meta_description, String, desc: "A short description for SEO and internal purposes"
          optional :rank, Integer, desc: "The rank can be used to determine the ordering of categories"
          optional :front_page, String, desc: "Whether or not the category should appear on the front page"
          optional :active, Boolean, desc: "Whether or not the category is live on the site"
        end
        post "", root: :categories do
          category = Category.create!(
            name: permitted_params[:name],
            icon: permitted_params[:icon],
            keywords: permitted_params[:keywords],
            title_tag: permitted_params[:title_tag],
            meta_description: permitted_params[:meta_description],
            rank: permitted_params[:rank],
            front_page: permitted_params[:front_page],
            active: permitted_params[:active]
          )
          present category, with: Entity::Category
        end

        # EDIT CATEGORY
        desc "Edit a single category", {
          entity: Entity::Category,
          notes: "Edit a single category"
        }
        params do
          requires :id, type: Integer, desc: "Category to update"
          requires :name, String, desc: "The name of the category of articles"
          optional :icon, String, desc: "An icon that represents the category"
          optional :keywords, String, desc: "Keywords that will be used for internal search and SEO"
          optional :title_tag, String, desc: "An alternate title tag that will be used if provided"
          optional :meta_description, String, desc: "A short description for SEO and internal purposes"
          optional :rank, Integer, desc: "The rank can be used to determine the ordering of categories"
          optional :front_page, String, desc: "Whether or not the category should appear on the front page"
          optional :active, Boolean, desc: "Whether or not the category is live on the site"
        end
        patch ":id", root: :categories do
          category = Category.where(id: permitted_params[:id]).first
          category.update!(
            name: permitted_params[:name],
            icon: permitted_params[:icon],
            keywords: permitted_params[:keywords],
            title_tag: permitted_params[:title_tag],
            meta_description: permitted_params[:meta_description],
            rank: permitted_params[:rank],
            front_page: permitted_params[:front_page],
            active: permitted_params[:active]
          )
          present category, with: Entity::Category
        end

      end

    end
  end
end