# Image Uploads with Active Storage Demo

This demonstration shows how to use Rails [Active Storage](https://guides.rubyonrails.org/v7.0/active_storage_overview.html) to add image uploads to the quiz questions from the [Resource Ownership Demo](https://rails-demos-n-deets-2023.herokuapp.com/demos/resource-ownership).

If you would like to follow along with the video, clone this repo and switch to the `version-before-demo` branch. The `main` (default) branch holds the solution.

## Video Demo (17 minutes)

[![Screenshot of edit-question form webpage with an image-upload field](edit_question_with_image_upload.png)](https://youtu.be/bUEDZoIEXB8?si=CD1OD2Z5gScD1iNO)

### [🎦 Watch the Video Demo](https://youtu.be/bUEDZoIEXB8?si=CD1OD2Z5gScD1iNO)

## Steps to Add Image Uploads

### ① Install Active Storage

Run `rails active_storage:install` and `rails db:migrate:reset`.

### ② Add Attachment to Model

In `app/models/question.rb`, add a declaration to the `Question` class to specify that each question has one attached figure image.

```ruby
has_one_attached :figure_image
```

### ③ Add File Field to Forms

In `app/views/questions`, in `new.html.erb` and `edit.html.erb`, add to each form a file field to enable users to select an image file to upload.

```erb
<%= f.file_field :figure_image %>
```

### ④ Permit File Params in Controller

In `app/controllers/questions_controller.rb`, in the `create` and `update` actions, update the permitted parameters to include an uploaded figure image.

```ruby
params.require(:question).permit(:question, :figure_image, :answer, :distractor_1, :distractor_2)
```

### ⑤ Display Attached Image in View

In `app/views/questions/show.html.erb`, add code to display the figure image if one is attached to the question.

```erb
<% if @question.figure_image.attached? %>
  <div class="my-4">
    <%= image_tag @question.figure_image, class: 'w-100 d-block mx-auto', style: 'max-width: 32rem;' %>
  </div>
<% end %>
```

## Steps to Seed Image Attachments

### ① Save Image Files with DB Seeds

Run `mkdir -p db/seeds/images` and save the three seed images (see appendix below) to the `db/seeds/images` folder.

### ② Attach Images in DB Seeds Script

In `db/seeds.rb`, for each of the three `quiz1` questions created, attach the relevant seed image.

```ruby
quiz1_q1.figure_image.attach(io: File.open(Rails.root.join('db/seeds/images/capitol.jpeg')), filename: 'capitol.jpeg')
```

## Further Reading

- [Active Storage Guide](https://guides.rubyonrails.org/v7.0/active_storage_overview.html)
- [Using Active Storage in Rails 7](https://pragmaticstudio.com/tutorials/using-active-storage-in-rails)

## Appendix: Seed Images

![The United States Capitol](db/seeds/images/capitol.jpeg)

- "[The dome of the US Capitol building](https://en.m.wikipedia.org/wiki/File:US_Capitol_dome_Jan_2006.jpg)" by [Diliff](https://commons.wikimedia.org/wiki/User:Diliff), used under [CC BY 2.5](https://creativecommons.org/licenses/by/2.5/).

![The United States Declaration of Independence](db/seeds/images/declaration.jpeg)

- "[The United States Declaration of Independence](https://commons.wikimedia.org/wiki/File:United_States_Declaration_of_Independence.jpg)", used under public domain.

![Map of America by Sebastian Munster](db/seeds/images/map.jpeg)

- "[Map of America by Sebastian Munster](https://en.m.wikipedia.org/wiki/File:Map_of_America_by_Sebastian_Munster.JPG)", used under public domain.
