from ctypes import byref, create_string_buffer
from bb.aes import *
 
class AES:
	def __init__(self, key, mode):
		self.keybytes = key.encode('ascii')
		self.mode = mode
 
		self.ctx = sb_GlobalCtx()
		self.key = sb_Key()
		self.params = sb_Params()
 
		rc = hu_GlobalCtxCreateDefault(byref(self.ctx)); assert not rc, 'rc is %s' % rc
		rc = hu_RegisterSbg56(self.ctx); assert not rc, 'rc is %s' % rc
		rc = hu_RegisterSystemSeed(self.ctx); assert not rc, 'rc is %s' % rc
		rc = hu_InitSbg56(self.ctx); assert not rc, 'rc is %s' % rc
 
		rc = hu_AESParamsCreate(self.mode, SB_AES_128_BLOCK_BITS, None, None, byref(self.params), self.ctx); assert not rc, 'rc is %s' % rc
		rc = hu_AESKeySet(self.params, len(self.keybytes) * 8, self.keybytes, byref(self.key), self.ctx); assert not rc, 'rc is %s' % rc
 
 
	def __del__(self):
		hu_GlobalCtxDestroy(byref(self.ctx))
 
 
	def encrypt(self, plaintext):
		cipher = create_string_buffer(len(plaintext))
		iv = create_string_buffer(16)
		rc = hu_AESEncryptMsg(self.params, self.key, len(iv), iv,
			len(plaintext), plaintext, cipher, self.ctx); assert not rc, 'rc is %s' % rc
		return bytes(cipher)
 
 
	def decrypt(self, ciphertext):
		plain = create_string_buffer(len(ciphertext))
		iv = create_string_buffer(16)
		rc = hu_AESDecryptMsg(self.params, self.key, len(iv), iv,
			len(ciphertext), ciphertext, plain, self.ctx); assert not rc, 'rc is %s' % rc
		return bytes(plain)
 
 
 
def new(key, mode):
	return AES(key, mode)
 
 
def _test():
	crypto = new('M02cnQ51Ji97vwT4', SB_AES_ECB)
 
	# Note: no padding done here... provide it yourself (PKCS#7)
	# This plaintext is carefully chosen to be a multiple of the block size.
	plain = 'This is a fine kettle of fish!!!'
	assert (len(plain) % 16) == 0
	cipher = crypto.encrypt(plain.encode('utf-8'))
	print('cipher', cipher)
	recovered = crypto.decrypt(cipher).decode('utf-8')
	print('recovered', repr(recovered))
	assert plain == recovered
 
 
if __name__ == '__main__':
	_test()

