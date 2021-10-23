# STI or Polymorphic collection for Project images

This code was presented as a working solution in a discussion about using polymorphic associations.

In this case a simple **`STI`** or polymorphic collection of images in `Project` 
seems to be more appropriate at first glance, but that may not fit the developer's 
requirement in this case.

### Implementation as implied by problem discussion

```ruby
class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
end

class ImageOne < ApplicationRecord
  belongs_to :project
  has_many :images, as: :imageable
end

class ImageTwo < ApplicationRecord
  belongs_to :project
  has_many :images, as: :imageable
end

class Project < ApplicationRecord
  has_one :image_one
  has_one :image_two
end
```

### Exercise in Rails console
```sh
$ bin/rails c
Loading development environment (Rails 7.0.0.alpha2)
irb(main):001:0> Project.create(name: "test")
irb(main):002:0> ImageOne.create(project: Project.first)
irb(main):002:0> ImageTwo.create(project: Project.first)
irb(main):005:0> ImageOne.first.images.create(url: "/images/test1")
irb(main):006:0> ImageTwo.first.images.create(url: "/images/test1")
irb(main):012:0> ImageTwo.first.project
irb(main):013:0> ImageTwo.first.project.image_one

```


### Creating the app

#### ** Performed on Linux Ubuntu 20.04 LTS

#### Install Rails 7 if needed

``` sh
rails_ver=`rails -v | cut -d ' ' -f 2`
rails_7_ver='7.0.0.alpha2'

if [ "$rails_ver" = "$rails_7_ver" ]
then
    echo "Rails $rails_7_ver already installed, yay!"
else    
    echo "Installing Rails version $rails_7_ver"
    gem install rails -v $rails_7_ver
fi    

```

#### Create a Rails 7 app (with tailwind, esbuild and postgresql)
```sh
rails new project_images -j esbuild --css tailwind --database postgresql
```

#### Generate the models
```sh
$ cd project_images
$ bin/rails g model Project name:string 
$ bin/rails g model Image url:string imageable_type:string imageable_id:integer
$ bin/rails g model ImageOne project:references
$ bin/rails g model ImageTwo project:references
``` 

#### manual Model Edits

`app/project.rb`
```ruby
class Project < ApplicationRecord
  # added manually
  has_one :image_one
  has_one :image_two
end
```

`app/image.rb`
```ruby
class Image < ApplicationRecord
  # added manually
  belongs_to :imageable, polymorphic: true
end
```

`app/image_one.rb`
```ruby
class ImageOne < ApplicationRecord
  belongs_to :project
  
  # added manually  
  has_many :images, as: :imageable
end
```

`app/image_two.rb`
```ruby
class ImageOne < ApplicationRecord
  belongs_to :project

  # added manually
  has_many :images, as: :imageable
end
```

