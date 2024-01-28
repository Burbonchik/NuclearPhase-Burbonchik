#define CLOSET_HAS_LOCK  1
#define CLOSET_CAN_BE_WELDED 2

#define CLOSET_STORAGE_MISC       1
#define CLOSET_STORAGE_ITEMS      2
#define CLOSET_STORAGE_MOBS       4
#define CLOSET_STORAGE_STRUCTURES 8
#define CLOSET_STORAGE_ALL   (~0)

#define NONE 0

//for convenience
#define ENABLE_BITFIELD(variable, flag) (variable |= (flag))
#define DISABLE_BITFIELD(variable, flag) (variable &= ~(flag))
#define CHECK_BITFIELD(variable, flag) (variable & (flag))
#define TOGGLE_BITFIELD(variable, flag) (variable ^= (flag))
#define COPY_SPECIFIC_BITFIELDS(a,b,flags)\
	do{\
		var/_old = a & ~(flags);\
		var/_cleaned = b & (flags);\
		a = _old | _cleaned;\
	} while(0);
#define CHECK_MULTIPLE_BITFIELDS(flagvar, flags) (((flagvar) & (flags)) == (flags))

/* Bitflags for flag variables.
These are used instead of separate boolean vars to reduce the overall number of variables,
especially on common types like /atom or /atom/movable.

- FLAG SETTING
// When setting default flags on type definitions, they are combined with bitwise OR:
// atom_flags = ATOM_FLAG_CLIMBABLE | ATOM_FLAG_OPEN_CONTAINER | ATOM_FLAG_NO_TEMP_CHANGE
// Be mindful of flags set on parent types, as setting flags on a child type will override the parent flags.
// Flags are also set at runtime with bitwise OR:
// atom_flags |= ATOM_FLAG_CLIMBABLE
// Flags are removed with bitwise AND NOT:
// atom_flags &= ~ATOM_FLAG_CLIMBABLE
// Flags can be toggled with bitwise XOR:
// atom_flags ^= ATOM_FLAG_CLIMBABLE

- FLAG CHECKING
Flags can be tested with bitwise AND:
	if (atom_flags & ATOM_FLAG_CLIMBABLE)
		to_world_log("[src] is climbable!")
- To test if a flag is not present, use:
	if (!(atom_flags & ATOM_FLAG_CLIMBABLE))
rather than
	if ((!atom_flags & ATOM_FLAG_CLIMBABLE))
The latter will result in a linter warning and will not work correctly.
*/

// Atom-level flags (/atom/var/atom_flags)
#define ATOM_FLAG_CHECKS_BORDER           BITFLAG(0)  // If a dense atom (potentially) only blocks movements from a given direction, i.e. window panes
#define ATOM_FLAG_CLIMBABLE               BITFLAG(1)  // This object can be climbed on
#define ATOM_FLAG_NO_BLOOD                BITFLAG(2)  // Used for items if they don't want to get a blood overlay.
#define ATOM_FLAG_NO_REACT                BITFLAG(3)  // Reagents don't react inside this container.
#define ATOM_FLAG_OPEN_CONTAINER          BITFLAG(4)  // Is an open container for chemistry purposes.
#define ATOM_FLAG_INITIALIZED             BITFLAG(5)  // Has this atom been initialized
#define ATOM_FLAG_NO_TEMP_CHANGE          BITFLAG(6)  // Reagents do not cool or heat to ambient temperature in this container.
#define ATOM_FLAG_CAN_BE_PAINTED          BITFLAG(7)  // Can be painted using a paint sprayer or similar.
#define ATOM_FLAG_SHIELD_CONTENTS         BITFLAG(8)  // Protects contents from some global effects (Solar storms)
#define ATOM_FLAG_ADJACENT_EXCEPTION      BITFLAG(9)  // Skips adjacent checks for atoms that should always be reachable in window tiles
#define ATOM_FLAG_NO_DISSOLVE             BITFLAG(10) // Bypasses solvent reactions in the container.
#define ATOM_FLAG_NO_PHASE_CHANGE         BITFLAG(11) // Bypasses heating and cooling product reactions in the container.
#define ATOM_FLAG_BLOCK_DIAGONAL_FACING   BITFLAG(12) // Atom cannot face non-cardinal directions.

#define ATOM_IS_OPEN_CONTAINER(A)         (A.atom_flags & ATOM_FLAG_OPEN_CONTAINER)

// Movable-level flags (/atom/movable/movable_flags)
#define MOVABLE_FLAG_PROXMOVE             BITFLAG(0) // Does this object require proximity checking in Enter()?
#define MOVABLE_FLAG_Z_INTERACT           BITFLAG(1) // Should attackby and attack_hand be relayed through ladders and open spaces?
#define MOVABLE_FLAG_EFFECTMOVE           BITFLAG(2) // Is this an effect that should move?
#define MOVABLE_FLAG_DEL_SHUTTLE          BITFLAG(3) // Shuttle transistion will delete this.
#define MOVABLE_FLAG_WHEELED              BITFLAG(4) // Movable has reduced stamina cost/speed reduction when pulled.

// Object-level flags (/obj/obj_flags)
#define OBJ_FLAG_ANCHORABLE               BITFLAG(0) // This object can be stuck in place with a tool
#define OBJ_FLAG_CONDUCTIBLE              BITFLAG(1) // Conducts electricity. (metal etc.)
#define OBJ_FLAG_ROTATABLE                BITFLAG(2) // Can be rotated with alt-click
#define OBJ_FLAG_NOFALL                   BITFLAG(3) // Will prevent mobs from falling
#define OBJ_FLAG_MOVES_UNSUPPORTED        BITFLAG(4) // Object moves with shuttle transition even if turf below is a background turf.

// Item-level flags (/obj/item/item_flags)
#define ITEM_FLAG_NO_BLUDGEON             BITFLAG(0) // When an item has this it produces no "X has been hit by Y with Z" message with the default handler.
#define ITEM_FLAG_NO_CONTAMINATION        BITFLAG(1) // Does not get contaminated.
#define ITEM_FLAG_NO_PRINT                BITFLAG(2) // This object does not leave the user's prints/fibres when using it
#define ITEM_FLAG_INVALID_FOR_CHAMELEON   BITFLAG(3) // Chameleon items cannot mimick this.
#define ITEM_FLAG_THICKMATERIAL           BITFLAG(4) // Prevents syringes, reagent pens, and hyposprays if equiped to slot_suit or slot_head_str.
#define ITEM_FLAG_AIRTIGHT                BITFLAG(5) // Functions with internals.
#define ITEM_FLAG_NOSLIP                  BITFLAG(6) // Prevents from slipping on wet floors, in space, etc.
#define ITEM_FLAG_BLOCK_GAS_SMOKE_EFFECT  BITFLAG(7) // Blocks the effect that chemical clouds would have on a mob -- glasses, mask and helmets ONLY! (NOTE: flag shared with ONESIZEFITSALL)
#define ITEM_FLAG_FLEXIBLEMATERIAL        BITFLAG(8) // At the moment, masks with this flag will not prevent eating even if they are covering your face.
#define ITEM_FLAG_IS_BELT                 BITFLAG(9) // Items that can be worn on the belt slot, even with no undersuit equipped
#define ITEM_FLAG_SILENT                  BITFLAG(10) // sneaky shoes
#define ITEM_FLAG_NOCUFFS                 BITFLAG(11) // Gloves that have this flag prevent cuffs being applied
#define ITEM_FLAG_CAN_HIDE_IN_SHOES       BITFLAG(12) // Items that can be hidden in shoes that permit it
#define ITEM_FLAG_PADDED                  BITFLAG(13) // When set on gloves, will act like pulling punches in unarmed combat.
#define ITEM_FLAG_HOLLOW                  BITFLAG(14) // Modifies initial matter values to be lower than w_class normally sets.
#define ITEM_FLAG_CAN_TAPE                BITFLAG(15) //Whether the item can be be taped onto something using tape

// Flags for pass_flags (/atom/var/pass_flags)
#define PASS_FLAG_TABLE                   BITFLAG(0)
#define PASS_FLAG_GLASS                   BITFLAG(1)
#define PASS_FLAG_GRILLE                  BITFLAG(2)
#define PASS_FLAG_MOB                     BITFLAG(3)

// Overmap sector flags (/obj/effect/overmap/visitable/var/sector_flags)
#define OVERMAP_SECTOR_BASE               BITFLAG(0) // Whether or not this sector is a starting sector. Z levels contained in this sector are added to station_levels
#define OVERMAP_SECTOR_KNOWN              BITFLAG(1) // Makes the sector show up on nav computers
#define OVERMAP_SECTOR_IN_SPACE           BITFLAG(2) // If the sector can be accessed by drifting off the map edge
#define OVERMAP_SECTOR_UNTARGETABLE       BITFLAG(3) // If the sector is untargetable by missiles.

//Ore flags. All processing flags are ordered after each other.
#define ORE_FLAG_CRUSHED                  BITFLAG(0) //crushed to dust
#define ORE_FLAG_SEPARATED_CRUDE          BITFLAG(1) //separated either by sifting or hand-picking
#define ORE_FLAG_SEPARATED_GOOD           BITFLAG(2) //separated either by magnets or flotation
#define ORE_FLAG_SEPARATED_BEST           BITFLAG(3) //separated by chemical processing
#define ORE_FLAG_RUINED                   BITFLAG(4) //you messed up

// Decl-level flags (/decl/var/decl_flags)
#define DECL_FLAG_ALLOW_ABSTRACT_INIT       BITFLAG(0)  // Abstract subtypes without this set will CRASH() if fetched with GET_DECL().
#define DECL_FLAG_MANDATORY_UID             BITFLAG(1)  // Requires uid to be non-null.