Class User.Ternary
{
  ClassMethod TernaryExample() {
    // There don't seem to be native ternary operators in ObjectScript, but we can fool it by making use of decision logic like so
    set x = 1
    set result = $select(x = 1: "true", x = 0: "false")
    
    // Common languages use the following pattern
    // <condition> ? <if true expression> : <if false expression>
    // And our usage has a similar pattern now
    // set result = $select(<condition> : <if true expression>, result-value : <if false expression>, result-value)
  }
}
