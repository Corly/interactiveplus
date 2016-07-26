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
        link_to(name, '#', class: "add_fields_question btn btn-primary", data: {id: id, fields: fields.gsub("\n", "")})
    end

    def link_to_add_answers(name, f, association)
        new_object= f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
            render(association.to_s.singularize + "_fields", f: builder)
        end
        link_to(name, '#', class: "add_fields_answer btn btn-primary", :id => "answer_button", data: {id: id, fields: fields.gsub("\n", "")})
    end
end
