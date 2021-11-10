type ('a, 'b) t = T : ('a, 'a) t

type ('a, 'b) equal = ('a, 'b) t

let refl = T
let sym (type a b) (T : (a, b) t) : (b, a) t = T
let trans (type a b c) (T : (a, b) t) (T : (b, c) t) : (a, c) t = T
let conv (type a b) (T : (a, b) t) (a : a) : b = a

let detuple2 (type a1 a2 b1 b2) (T : (a1 * a2, b1 * b2) t) : (a1, b1) t * (a2, b2) t =
  T, T
;;

let tuple2 (type a1 a2 b1 b2) (T : (a1, b1) t) (T : (a2, b2) t) : (a1 * a2, b1 * b2) t = T

module type Injective = sig
  type 'a t

  val strip : ('a t, 'b t) equal -> ('a, 'b) equal
end

module type Injective2 = sig
  type ('a1, 'a2) t

  val strip : (('a1, 'a2) t, ('b1, 'b2) t) equal -> ('a1, 'b1) equal * ('a2, 'b2) equal
end

module Composition_preserves_injectivity (M1 : Injective) (M2 : Injective) = struct
  type 'a t = 'a M1.t M2.t

  let strip e = M1.strip (M2.strip e)
end

module Id = struct
  module Uid = Int

  module Witness = struct
    module Key = struct
      type _ t = ..
      type type_witness_int = [ `type_witness of int ]
    end

    module type S = sig
      type t
      type _ Key.t += Key : t Key.t
    end

    type 'a t = (module S with type t = 'a)

    let create (type t) () =
      let module M = struct
        type nonrec t = t
        type _ Key.t += Key : t Key.t
      end
      in
      (module M : S with type t = t)
    ;;

    let uid (type a) (module M : S with type t = a) =
      Obj.Extension_constructor.id (Obj.Extension_constructor.of_val M.Key)
    ;;

    (* We want a constant allocated once that [same] can return whenever it gets the same
       witnesses.  If we write the constant inside the body of [same], the native-code
       compiler will do the right thing and lift it out.  But for clarity and robustness,
       we do it ourselves. *)
    let some_t = Some T

    let same (type a b) (a : a t) (b : b t) : (a, b) equal option =
      let module A = (val a : S with type t = a) in
      let module B = (val b : S with type t = b) in
      match A.Key with
      | B.Key -> some_t
      | _ -> None
    ;;
  end


  type 'a t =
    { witness : 'a Witness.t
    ; name : string
    }

  let name t = t.name
  let create ~name = { witness = Witness.create (); name; }
  let same_witness t1 t2 = Witness.same t1.witness t2.witness
  let same t1 t2 = Option.is_some (same_witness t1 t2)
end
