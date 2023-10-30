module Parser where
    import Token
    import qualified Text.Parsec.Token as Token
    import qualified Text.Parsec.Token as Token
    
    data BExpr = BoolConst Bool
            | Not BExpr
            | BBinary BBinOp BExpr BExpr
            | RBinary RBinOp AExpr AExpr
            deriving (Show)

    data BBinOp = And | Or deriving (Show)

    data RBinOp = Greater | Less deriving (Show)

    data AExpr = Expr String
                | IntConst Integer
                | Neg AExpr
                | ABinary ABinOp AExpr AExpr
                deriving (Show)

    data ABinOp = Add | Subtract | Multiply | Divide | Modulus deriving (Show)

    data Stmt = Seq [Stmt]
                | Assign String AExpr
                | If BExpr Stmt Stmt
                | While BExpr Stmt
                | Return
                deriving (Show)

    languageDef = emptyDef {
        Token.commentStart = "/*",
        Token.commentEnd = "*/",
        Token.commentLine = "//",
        Token.identStart = letter,
        Token.identLetter = alphaNum,
        Token.reservedNames = ["if", "then", "else", "while", "do", "return", "true", "false", "not", "and", "or", "enum", "class", "struct"],
        Token.reservedOpNames = ["+", "-", "*", "/", ":=", "<", ">", "and", "or", "not", "==", "=", "\""]
    }

    lexer = Token.makeTokenParser languageDef

    