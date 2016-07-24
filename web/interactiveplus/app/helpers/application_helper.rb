module ApplicationHelper

    def full_title(page_title = '')
        base_title = "Interactive+"
        if page_title.empty?
            base_title
        else
            page_title + " | " + base_title
        end
    end

    def link_to_add_questions(name, f, association)
        new_object= f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
            render(association.to_s.singularize + "_fields", f: builder)
        end
        button_to(name, '#', class: "add_fields btn btn-primary", data: {id: id, fields: fields.gsub("\n", "")}, :method => :get)
    end

    def link_to_add_answers(name, f, association)
        new_object= f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
            render(association.to_s.singularize + "_fields", f: builder)
        end
        button_to(name, '#', class: "add_fields btn btn-primary disabled", :id => "answer_button", data: {id: id, fields: fields.gsub("\n", "")}, :method => :get)
    end
end
