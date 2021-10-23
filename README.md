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
