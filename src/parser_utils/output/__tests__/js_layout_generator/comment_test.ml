(**
 * Copyright (c) 2013-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open OUnit2

open Layout_test_utils
open Layout_generator_test_utils

module L = Layout_builder

let tests = [
  "block" >::
    begin fun ctxt ->
      let comment = Ast_builder.Comments.block "test" in
      let layout = Js_layout_generator.comment comment in
      assert_layout ~ctxt
        L.(loc (fused [
          atom "/*";
          pretty_newline;
          atom "test";
          pretty_newline;
          atom "*/";
        ]))
        layout;
      assert_output ~ctxt "/*test*/" layout;
      assert_output ~ctxt ~pretty:true "/*\ntest\n*/" layout;
    end;

  "line" >::
    begin fun ctxt ->
      let comment = Ast_builder.Comments.line "test" in
      let layout = Js_layout_generator.comment comment in
      assert_layout ~ctxt
        L.(loc (fused [
          atom "//";
          atom "test";
          Layout.Newline;
        ]))
        layout;
      assert_output ~ctxt "//test\n" layout;
      assert_output ~ctxt ~pretty:true "//test\n" layout;
    end;
]
