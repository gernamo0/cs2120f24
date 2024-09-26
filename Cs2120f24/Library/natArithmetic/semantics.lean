import «cs2120f24».Library.natArithmetic.syntax
import «cs2120f24».Library.natArithmetic.domain

namespace cs2120f24.natArithmetic.semantics

open cs2120f24.natArithmetic.syntax

def evalUnOp : UnOp → (Nat → Nat)
| UnOp.inc => Nat.succ
| UnOp.dec => Nat.pred
| UnOp.doub => (fun n => n * 2)
| UnOp.halve => (fun n => n / 2)
| UnOp.fac => natArithmetic.domain.fac

def evalBinOp : BinOp → (Nat → Nat → Nat)
| BinOp.add => Nat.add
| BinOp.sub => Nat.sub
| BinOp.mul => Nat.mul

def evalRelOp : RelOp → (Nat → Nat → Bool)
| RelOp.eq => natArithmetic.domain.eq
| RelOp.le => natArithmetic.domain.le
| RelOp.lt => natArithmetic.domain.lt
| RelOp.ge => natArithmetic.domain.ge
| RelOp.gt => natArithmetic.domain.gt

def Interp := NatVar → Nat

def evalVar : NatVar → Interp → Nat
| v, i => i v   -- apply interpretation function i to variable v

abbrev NatInterp := NatVar → Nat -- varInterp would be better name

open ArithExpr

-- Semantics
def evalExpr : ArithExpr → NatInterp → Nat
| lit (n : Nat),    _ =>  n
| var (v : NatVar),    i => (evalVar v i)
| unOp op e,        i => (evalUnOp op) (evalExpr e i)
| binOp op e1 e2,   i => (evalBinOp op) (evalExpr e1 i) (evalExpr e2 i)

open RelExpr

def evalRelExpr : RelExpr → NatInterp → Bool
| (mk op a1 a2), i =>  (evalRelOp op) (evalExpr a1 i) (evalExpr a2 i)

end cs2120f24.natArithmetic.semantics
