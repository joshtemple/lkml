from typing import List
import lkml.tokens as tokens


class Lexer:
    def __init__(self, text):
        self.text = text + "\0"
        self.index = 0
        self.tokens = []

    def peek(self, length=1):
        return self.text[self.index : self.index + length]

    def advance(self, length=1):
        self.index += length

    def consume(self):
        ch = self.peek()
        self.advance()
        return ch

    def scan_until_token(self):
        found = False
        while not found:
            while self.peek() in "\r\n\t ":
                self.advance()
            if self.peek() == "#":
                while self.peek() not in "\0\r\n":
                    self.advance()
            else:
                found = True

    def scan(self):
        self.tokens.append(tokens.StreamStartToken())
        while True:
            self.scan_until_token()
            ch = self.peek()
            if ch == "\0":
                self.tokens.append(tokens.StreamEndToken())
                break
            elif ch == "$":
                if self.peek(2) == "${":
                    self.advance(2)
                    self.tokens.append(tokens.ReferenceStartToken())
                    self.tokens.append(self.scan_literal())
                    self.advance()
                    self.tokens.append(tokens.ReferenceEndToken())
            elif ch == "{":
                self.advance()
                self.tokens.append(tokens.BlockStartToken())
            elif ch == "}":
                self.advance()
                self.tokens.append(tokens.BlockEndToken())
            elif ch == "[":
                self.advance()
                self.tokens.append(tokens.ListStartToken())
            elif ch == "]":
                self.advance()
                self.tokens.append(tokens.ListEndToken())
            elif ch == ",":
                self.advance()
                self.tokens.append(tokens.CommaToken())
            elif ch == ":":
                self.advance()
                self.tokens.append(tokens.ValueToken())
            elif ch == ".":
                self.advance()
                self.tokens.append(tokens.DotToken())
            elif ch == ";":
                if self.peek(2) == ";;":
                    self.advance(2)
                    self.tokens.append(tokens.SqlEndToken())
            elif ch == '"':
                self.advance()
                self.tokens.append(self.scan_quoted_literal())
            else:
                # TODO: This should actually check for valid literals first
                # and throw an error if it doesn't match
                self.tokens.append(self.scan_literal())

    def scan_literal(self):
        chars = ""
        while self.peek() not in "\0 \r\n\t:},.]":
            chars += self.consume()
        return tokens.LiteralToken(chars)

    def scan_quoted_literal(self):
        # TODO: Check and see if literals can be single-quoted
        chars = ""
        while self.peek() != '"':
            chars += self.consume()
        self.advance()
        return tokens.QuotedLiteralToken(chars)


if __name__ == "__main__":
    string = """view: orders {
  sql_table_name: dbt_dev.orders ;;

  set: ordered_date_fields {
    fields: [
      ordered_time, ordered_hour_of_day, ordered_date,
      ordered_day_of_week, ordered_week, ordered_month,
      ordered_quarter, ordered_year, ordered_raw]
  }

  dimension: order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.order_id ;;
    link: {
      label: "View on Shopifiy"
      url: "https://milk-bar-development.myshopify.com/admin/orders/{{ source_order_id }}"
      icon_url: "https://cdn.shopify.com/shopify-marketing_assets/static/shopify-favicon.png"
    }
    link: {
      label: "View on Brink"
      url: "https://admin3.brinkpos.net/Orders/Order/{{ source_order_id }}"
      icon_url: "https://admin3.brinkpos.net/assets/ico/favicon.png"
    }
  }

  dimension: source_order_id {
    description: "Order identifier in the original system (see the Source dimension)"
    type: string
    sql: ${TABLE}.source_order_id ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: store_id {
    hidden: yes
    type: string
    sql: ${TABLE}.store_id ;;
  }
    """
    print(string)
    l = Lexer(string)
    l.scan()
    print(l.tokens)
