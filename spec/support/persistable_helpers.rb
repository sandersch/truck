class Boolean; end

#module Mongoid
  #module Errors
    #class DocumentNotFound < StandardError
    #end
  #end
#end

module BSON
  class ObjectId

  end
end

require 'active_support/concern'
module Persistable
  extend ActiveSupport::Concern

  def save
    true
  end

  def has_field?(name)
    self.class.fields.include?(name.to_s)
  end

  def has_scope?(name, *args)
    self.class.scopes.include?(name.to_s) and self.class.scopes[name.to_s] == args
  end

#  def method_missing(name, *args, &block)
    #puts "#{name} method called on #{self.class}"
    #swallow
#  end

  def persisted?
  end

  def id
    'id'
  end

  def _id
    '_id'
  end

  def errors
    {}
  end

  def update_attributes(hash)
    hash.each_pair do |key, value|
      self.public_method("#{key}=".to_sym).call(value)
    end
  end

  module ClassMethods
    def fields
      @fields ||= {}
    end

    def scopes
      @scopes ||= {}
    end

    def field(name, *args)
      fields[name.to_s] = args.flatten

      Persistable.class_eval "attr_accessor :#{name}"

      if args.first[:type] == Boolean
        define_method("#{name}?") { !!(self.send(name)) }
      end
    end

    def scope(name, *args)
      scopes[name.to_s] = args.flatten
      self.class.instance_eval do
        define_method(name) do
          []
        end
      end
    end

    def where(*args)
      args
    end

    def belongs_to(name, *)
      attr_accessor name.to_sym
    end

    %w(index embeds_many embedded_in before_create validates_uniqueness_of validate validates validates_presence_of).each do |method|
      class_eval "def #{method}(*); end"
    end
  end
end

class Symbol
  def ne

  end
end

class Time
  def self.current
    now
  end
end
