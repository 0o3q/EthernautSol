from eth_abi.packed import encode_packed
from eth_utils import keccak
from eth_keys import keys
from ecdsa import SECP256k1
from ecdsa.ellipticcurve import Point

amount = 10000000000000000000
receiver = "0xA11CE84AcB91Ac59B0A4E2945C9157eF3Ab17D4e"
salt = bytes.fromhex("04a078de06d9d2ebd86ab2ae9c2b872b26e345d33f988d6d5d875f94e9c8ee1e")

voucherHash = keccak(encode_packed(['uint256', 'address', 'bytes32'], [amount, receiver, salt]))
print("voucherHash: ", voucherHash.hex())

receiverSignature = bytes.fromhex("ab1dcd2a2a1c697715a62eb6522b7999d04aa952ffa2619988737ee675d9494f2b50ecce40040bcb29b5a8ca1da875968085f22b7c0a50f29a4851396251de121c")
r = int(receiverSignature[:0x20].hex(), 16)
s = int(receiverSignature[0x20:0x40].hex(), 16)
v = int(receiverSignature[0x40:0x41].hex(), 16)

Sig = keys.Signature(vrs=(v-27, r, s))
publicKey = Sig.recover_public_key_from_msg_hash(voucherHash)
pub_x = int.from_bytes(publicKey.to_bytes()[:32], 'big')
pub_y = int.from_bytes(publicKey.to_bytes()[32:], 'big')
print("publicKey: ", publicKey.to_checksum_address())

curve = SECP256k1.curve
G = SECP256k1.generator
n = SECP256k1.order
Q = Point(curve, pub_x, pub_y)

R = G + Q

r_forged = R.x() % n
s_forged = r_forged
e = r_forged
v_rec = 27 + (R.y() % 2)

if s_forged > n // 2:
    s_forged = n - s_forged
    v_rec = 28 if v_rec == 27 else 27

print("amount: ", hex(e))
print("tokenOwnerSignature: ", f"0x{r_forged:x}{s_forged:x}{v_rec:x}")