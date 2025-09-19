module.exports = grammar({
  name: 'twoif',

  extras: $ => [
    /\s/,
    $.comment
  ],

  rules: {
    source_file: $ => repeat($._item),

    _item: $ => choice(
      $.comment,
      $.head_command,
      $.control_command,
      $.cross_command,
      $.geom_command,
      $.material_command,
      $.contint_command,
      $.hist_command,
      $.time_command,
      $.gcload_command,
      $.gpdisp_command,
      $.glbon_command,
      $.visres_command,
      $.smerge_command,
      $.lmerge_command,
      $.fricmodel_command,
      $.rotate_command,
      $.displace_command
    ),

    comment: _ => /#[^\r\n]*/,

    // HEAD command
    head_command: $ => seq(
      'HEAD',
      /[^\r\n]*/
    ),

    // CONTROL command
    control_command: $ => seq(
      'CONTROL',
      $.number, // NLP
      $.number, // maxIt
      $.number, // convRat
      $.number, // seaDen
      $.number, // gAcc
      $.number  // avgTen
    ),

    // CROSS command
    cross_command: $ => seq(
      'CROSS',
      $.number,      // n
      $.identifier,  // name
      $.identifier,  // process
      $.number,      // N
      $.number,      // Lp
      $.number,      // R
      $.number,      // theta
      $.identifier,  // elemType
      $.identifier,  // geomName
      $.identifier   // matName
    ),

    // GEOM command
    geom_command: $ => prec.right(seq(
      'GEOM',
      $.identifier, // geomName
      choice('CLOSED', 'OPEN'), // form
      repeat($.geom_params)
    )),

    geom_params: $ => prec.right(seq(
      $.number, // Y0
      $.number, // Z0
      choice('CI', 'CO'), // curvType
      $.number, // P1
      $.number, // P2
      $.number, // r
      optional(seq(
        $.number, // thickness
        $.number, // nDiv
        $.number  // interfaceNo
      ))
    )),

    // MATERIAL command
    material_command: $ => seq(
      'MATERIAL',
      $.identifier, // materialName
      choice('LINEAR', 'NONLINEAR'), // type
      $.number, // nu
      $.number, // density
      $.number, // thermCoeff
      $.number, // thermCond
      $.number, // heatCap
      $.number, // E-mod
      $.number, // Beta
      choice('AUTO', $.identifier) // matCode
    ),

    // CONTINT command
    contint_command: $ => seq(
      'CONTINT',
      $.identifier, // masterGeom
      $.identifier, // slaveGeom
      choice('AUTO', $.identifier), // contName
      $.number, // interface
      $.number, // stiffness
      $.number, // frictCoeff
      $.number, // loadStep
      $.number, // gap1
      $.number, // gap2
      $.number  // iCode
    ),

    // HIST command
    hist_command: $ => seq(
      'HIST',
      $.number,
      repeat($.hist_entry)
    ),

    hist_entry: $ => seq(
      $.number, // step
      $.number  // value
    ),

    // TIME command
    time_command: $ => seq(
      'TIME',
      $.number, // totaltime
      $.number  // history no
    ),

    // GCLOAD command
    gcload_command: $ => seq(
      'GCLOAD',
      $.number, // DOF
      $.number, // value
      $.number  // historyNo
    ),

    // GPDISP command
    gpdisp_command: $ => seq(
      'GPDISP',
      $.number, // DOF
      $.number, // value
      $.number  // historyNo
    ),

    // GLBON command
    glbon_command: $ => seq(
      'GLBON',
      $.number
    ),

    // VISRES command
    visres_command: $ => seq(
      'VISRES',
      repeat1(choice($.identifier, /[A-Z0-9_-]+/))
    ),

    // SMERGE command
    smerge_command: $ => seq(
      'SMERGE',
      $.identifier
    ),

    // LMERGE command
    lmerge_command: $ => seq(
      'LMERGE',
      $.identifier
    ),

    // FRICMODEL command
    fricmodel_command: $ => seq(
      'FRICMODEL',
      $.number
    ),

    // ROTATE command
    rotate_command: $ => seq(
      'ROTATE',
      $.number
    ),

    // DISPLACE command
    displace_command: $ => seq(
      'DISPLACE',
      $.number
    ),

    // Basic tokens
    identifier: _ => /[A-Z_][A-Z0-9_-]*/,
    
    number: _ => choice(
      /[+-]?[0-9]+\.[0-9]*([eE][+-]?[0-9]+)?/, // Scientific notation
      /[+-]?[0-9]+([eE][+-]?[0-9]+)?/,         // Integer or scientific
      /[+-]?[0-9]*\.[0-9]+([eE][+-]?[0-9]+)?/  // Decimal
    )
  }
});