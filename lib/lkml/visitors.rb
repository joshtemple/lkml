# frozen_string_literal: true

require 'logger'

require_relative 'tree'

module Lkml
  class BasicVisitor < Visitor
    def _visit(node)
      if node.is_a?(SyntaxToken)
        nil
      elsif node.respond_to?(:children) && node.children
        node.children.each { |child| child.accept(self) }
      end
    end

    def visit(document)
      _visit(document)
    end

    def visit_container(node)
      _visit(node)
    end

    def visit_block(node)
      _visit(node)
    end

    def visit_list(node)
      _visit(node)
    end

    def visit_pair(node)
      _visit(node)
    end

    def visit_token(token)
      _visit(token)
    end
  end

  class LookMlVisitor < BasicVisitor
    def _visit(node)
      node.to_s
    end
  end

  class BasicTransformer < Visitor
    def _visit_items(node)
      if node.respond_to?(:children) && node.children
        new_children = node.children.map { |child| child.accept(self) }
        node.class.new(items: new_children)
      else
        node
      end
    end

    def _visit_container(node)
      if node.respond_to?(:container) && node.container
        new_child = node.container.accept(self)
        node.class.new(container: new_child)
      else
        node
      end
    end

    def visit(node)
      _visit_container(node)
    end

    def visit_container(node)
      _visit_items(node)
    end

    def visit_list(node)
      _visit_items(node)
    end

    def visit_block(node)
      _visit_container(node)
    end

    def visit_pair(node)
      node
    end

    def visit_token(token)
      token
    end
  end
end
