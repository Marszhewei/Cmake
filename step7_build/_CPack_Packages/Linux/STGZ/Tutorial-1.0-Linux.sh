#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This is License.

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +151 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
�  ��b �=	xW�otXr|&q�Q�4M�Z�|�=�8q�ȍ���C�.�D�F��,9�(u����jB ���.�o�,g�햖e�K��r��_	���mY{�ݚB�{$�����X�%����y����s޼y�;��$�Q���Cmm��Fā5��<`l_��nM}������W�kh�%��?�Q"d3z8��ә��Ζ��a�!!�ۿ3�l�&#z<���Ω�����iڿ> ڿ���j�W{N��	���?���%4���̮���Cë����6l&�%A��ެ�J�É�T2�?����] ���kp�764̌��"������͞MkQ_j��|�dԗ�t=����b��Ot�YE�X<��m����[��u�l���!h������ڹ�s]ohf��ӄ�x��������5�3뿷"`��a���1}�766������������ߊ�`�F����\M����V��6��J�I\W��I�.���t�c����-t2��O̱"Ůiʳ����<�[�����|T���-q���|X7��|�����u����8�;�b�+�X���f.��sl��t�x1��ܞg��������x�,�Ṉ�w-���D�vs}v�0�0Ǣ��$�}M5�hu"��W77U75�3)�a�Oا6m�F�ɨ���T�p1����"l ����w�����؞��[7>w���_�x9N#����f/&���
�a�w��m�z��)��Rl�@�� �������m�6������A��௷��N�߶��Ȇ��~�z�����W ��Fo��|�F�F���лm�/{fC/l]��J��U�0�T񮫫*Q�{;ը����]K�v�%RI�7ܗ�X^�����`�H�i*�	nwУ7h�h�=ң��pZ��Ḟ
x��}�L<��2zZ�����j��I��u���S7����p"U���젖Ի6G�&}��F���@r�I��:jU�-���=�*�OeT��ړq�[�
ӵ��'գ�����!-�I%�}����(hg��ƍi�$�����WG�^��Fըs	�9oܚ|�ERY�5@�h �����'�5�y[��x2�vkh���*<LB��E���]��x��um8��DOA�Q�t:�R�Hv�����Mj,O��ѣ�իq�oBp�H�G@B�"���M��ג���׭oW�z���}=��n���� �:���|��O|pop�\��)�v�,櫓~
�W��~����QG~��Z���'����|�����_�	nar���U���Yˁw��K�?p��U�x�y��wχ�,»b%�����X����@�w�z��'�#�ǪX|Ԃ�f!��Y�'�z�X�/�ѵ,�{�X�axT�����#�OJx��?%��J�1	?_�OH��~R�/���y9p�-������~!������O�;$�J	��^^5K�b	�*��=���/��]�T�o��e~��/���B�I�J	?,����~	_%����$�a	��̄��~[q�+��yC�?��azۨ�ȝ���!��k|
й���kŒVH!L_���A��I�q�?A�!�S��(��a�rǏS�[�T;~��_G������q��O��#��k|�F����8�8�wQ����3�J��!�S�x-�oE��q��"�S�x%����2N(��qJ�8��a}��}��C#O�<=���jy�k�;���.�X�^Z��*��!7�#t��>�:�gU]�;U�d?�=�c����7�]�UgB#��gm��IgHy8���
4r�ܩXŒy~�oKM���BZ�����3zY�`˽~4�Q@�E�l�;�P�᡼���ilo�7���@F����}w�F�������WR�����}w+����C�0�h��#c��B#��G�����
a�b_�◧��p�uHqpޜj�@�!�p�C�$W���LX����B��y�:M���e�н�����S�=�_A�Ӕ��������� swSC����=  �x7�3�G�&^�TT�r&�8%G��y��������]���k�D�m�ih��(����5��'W��(P�G�=�m,Z]E�R�{vuh�!ao+=�djt��>��oC��o�|�!��9*G��6��<��5%{�-�&s9�u`�y1i�������W3��߱��<�j.w�I| ���m1�	�7jB#�&�N@)'i��*
=y�^Z"���R&w�i�Zy�ò���A��J7R9��G�8l�;�
Б�F�ec/����6yp�H%������IZ��T:^��>��xhd۱�H�Q��������̶`ñ����XC���$d�]<�-�N�,������E&��s ���{����Y75	`��	`z��2x->:��(��'B�A;�ȣ��J �<$�G����1<b�6K�]�z	������-Z���R��O�*��U�O��19�6��ʲ_��d�o�}�A����BS�Z,��o�c/��>����}�(�e�!(M�w�d���*���
	>G�lx��M��Pi�	�Q�����P��Q.��Ҧ��{%��)C'\�S�	�y�+,~`���I�O��֗��>�5F���	�p+�+���P>���\q��s��r�?ۀm�u��I:`����K�Ⱥ�F�j�~���Ɗb&̄�0f�L�	��.`7�}o�ҙx*�#~�-�׮�_2;ا�I����ʆӚ/�J�T��_^ζ�F���~Ƨ�|Zb��'��p�O��x8��Nd5iKe�`�O�2i�ҧ	�bwty��?��~�Z���������1��O��=����=�]���F!���g >���.�k8�v�?�0�����",_�:B���|�V�I*����D�T�+�x+�g���H��C��ï~���l"��^SQr�w?Y���K��ר��v�� 7#b]y�펶�"�F� ����A5{>q�BB���s]a���V��2���*�!�Y�=��z�h6�~s��w��E�_)�of�h��W�����1�Q�vt@����M��4������͓��v��znW�|�-T�����_,,C.�,h9Dw;�/;ɗ�1'���k
͚��W�{�.�L�	3a&̄�0f�L�	o.��0���8�"η�����W���Z�p�8c�C��;�q�D��9��⌊8c"�߈��v~�L.E��C6b�<���3$c<_�����l��'���`��ie�8ò�T<��3;�L��3~h����/β���Xy����9�&8|����?קq���x�����8���<���w���<�����	���/����<^!n��8�5}�X{��+>��/��Ɲ�+���*�7 �wG���Ci���`��8[_����}�������O-�ҽ��MmmW�Vnڲm�/P��ŷ(x��9�s�w+l,:�ү$��b��3.���h�Z����M�%�0���3��s~��akXN��L����8�aEe��\��_9�I� �[�w����;x�����@q�<�y=!���G r�ࢬXp!�;ܟe�O�F���/F����
_�V���N�{1����$N��
&':���رx�Ndĳ(΅s�&���ù�������*����$�X,��U��R�/]�g�J��)�\��B+��~� ��������dv1��.�c�O���e xV="��F4��z5{]��P���h���}?^Χ.���E��U�=���>w����Od�O��u]�pU���2� ҁ�h�]XQxq`x.@c��8�8�	q�H�o��8C�V��qxq�.%��\��ŕ`h����ܪ� �3Y��X�Exj��rէP@яxm�U�������Q�G֟�����}?$�R�0���B����ކ�W)�*��r�,V�-C��1o�[H\k�+���!�}��'��gw⾂8�8��=7"�!����}ĭ�V�	�����������ǋ�{5�8�8���b�9�b�nL]�)�Vr��N�6��:��+1���b
�Á���L݃���� ���:n���n���� \�(�s!��%x���Y��Y�*��������<R�s�g =���� ����g���@}��5]�� ��d���c8��x�� ��?G�R�Z����_RA��ϰ���G��8�;�UO�A.�ŋ�vAF���2�HG)�p�Pw���<�w}�ߣ�g@�wC9�\R�I�MA�����>����8��k��C@�@޶��Q�MN�*v�-��-|�[����j�6��_�ʂ�+�P��<��f'���%\��f+l���%Ϝ�w3i��[�M$�lR�`�2��Y~^���sq�V*H�Ro�\0c�ȹ���\]�,�"���|�,���ʒ�K,*��fXy��*X�yy�[�+J�\xf-I5�)��8�KJ(�R/f�R��!�l%��i�ll,q.9oI%,�*�]p���P�%̞/���c���s(\#�\�uI	���h�7He�C)q��M1�i�.Bg�F^w����r�O��M�%~�U�W��0RحK�J��HW8�ez!�q#u6+[����]ݹ�����Tp(���O�	/�~�'1o��mx��G�wa{���g��{�/�5j�^�8�㭨
��aT�y����/�Ӯl5��c��K�VH-��*D,m�k���lK�y�b���Q6Ä�(7�A5k���+ �% Ma*�*ȹ�����̞LT��77�M5������њ~���&���T$��o�|�z|u��f�nC�t���#-�+B��lRk�גZ:�U�������3z��?����͗WǓ	t�PK���:$���4T��G+ՑD83P=�N�u����Ĳ� �t�VN$�#����:�H���h<���LΝJ�Q�T���IR�H[M��`(�٩����TTK��7��ڰ!�T�p4�V㙔$��!��Y�>��T�d��&5�H�O�$�l���h ��}8��3�L$5���(Bj,<O�!�D��A�.����@4��@�d��ưN�{�תm=�Ǝu��-[��`O��^u���;���U׷��&3$�E/hN�&3����h0�IE�@/F�:����M[�u0ePd%�0��	렮�ib�{H&�
B���eޫ�S$�"{f�\�M��j�b�
V���h�a�j4��y��
fH�&��>�Jn�*�i�$h��i���}S��ޠ����i��b��cPIذW������#錶K�d�O��3j_\�m�d�/���~�^xw�B{
GK��&�6��oUa��1ٌ%S��HZ���Q0#9��2����ȜS�W'a�#�&�IS1Q�/�o+��T&>\��AH�Z"&�f�@���9�A��^?�FT��+D�	68z�U�ôe6�,A%"y��C"���x4ס��>y�]�o���#�'�pl"0��=g{����&gŗ�<KE�Ϸ����;RNvZ�=.���|ǟ��{�=�I����T��g�׉p;��|��aJ_e����U�����������s�Ş1�wߨ����
Ë}O��w�2��V��6z'����z�>��k�^]t1�T^d�)L#5`���@�]T��)�otOw[�x<�Q�;�/)�P��,\g�/sc�\D�Z��s�2(�2^�K8�C�׮4:��r��ѿRe���|o�5� �P���*�t!߸����E0�f;M��[�,L�k���/9��I�Ov?�;*��3�i#��6��m�+ܬ���A��0}��ѧ������^gC������!�Qj�>c=[���]���?a#��f���ߪ)~1پތ�s�~����0�3�����X����e�?7s��"6��~OQa������;E�����x}�<���u��zc����eC�Q�v\DF[�������m�iq�_)�o�=�A2��A���l� C4��'R}���
Xb¢ �&���E���)���N��{T-����XV�j4;8�X$HEKL�:wj�S����I%���h*}Jg#��@G3�'S(�� ���#*h��^�p2��dʇpm<N�M[���\�d��v�r�9�d��و�,ԍ��:�jp����qdhC7Q7�ز�����u�ƞ`�ڻn}GP�� U��jt��^���U%�C+n�F#����Z�kc�ڵ�7�vu�ԫ�z�T�Q�.{.��'�[c����:��j8-Z-���!̕��]��J��fR� ���,�C̬o�Y����󧵘���DS�b�J�'�Ws�H^3��ڛpb)w"�)O�ԏ��b�s���ּ?��b���M�-�X��{ɇ�Ԏ�C�U0����j7z=�b6�=�`�x^���0S�}������`pz�)���d��rU4�Y�`��-=�뭕`נ�?�ΩݳU�b��1sM� ���U�`��X�h�s=���lg�$�M�?H�t��|��&2D��=�z�b�:h< R�9�C�O�
`�(��6��H(��Q�rt�j\Mм�pf���{����z���f�'� ��Z"��<5���
��0}��N��t���� _7�����HDe��*����`K
&C�AUx0��N/L%Ê�q��{��������f������[@��+Ҵ�y����	�Ӻ�|�7�q)*����aA���,����(���B����p��������/�c��2v����\.%�Ź�Q�~qn�j��3K�_�k�<C����3N��!�/�I�X���Z��;�$�Ź#7Y�wX�wv�I��\������N2�����%�?��sU��忋��CqNK��%���?Ed߇d�_Oq~Mk��m��U��JK�[݇~��/��E\#;�"S�ɗ,�b?B�ez���H�����<>n����?[���q���¿r�9~�RV�?��W]d�WY�����@�ab����>-�;�~��0Q�_��.l���41�3��r�Ji��|�)�L�_�)�^�[Ϣ���o0�kG��_e��7G9����g�+L���E<�4X�$K�~��g�o݋P,�Jej��P��',x��[c��cn^�m�WV�6�Ϭa�K���Z���Y��Y�o���W�x�e�Z�o�������/�a�ne�e�o
�i��#8xƵ�u��۔�I����,ت�c��8K����D����������"`�������V�Y��˚��:���ƺ@ӌ���",�
&]=��g�Sҵ&|}��݉+}��c��v��|Ҏ�?U3�t�&T���f!��
�
���n��_+am�f�M!w�����)���&�zd���1�	�)�o����#|������)�-��.O/!eS�����2Y&@٘�&[Sg���*��B�OSp��R��H`����H`��WYb�����U<�����y����B���ͺ�i�@�N��;y��x	a'y�x�9�:4�ċ#1�?����H��j2��oZ�C�)&o���>2�i�Gl�߳�?e��@)�����m�x⥲������Z��z[�vdv5����~'�������8(�j�����?
���Yh�16)�����{E�[�b�\/�q��}�t�>��x��\����B�@�_,�f�G�5O[�Q+f<� �^��J�̰ؿR�WJ�:�|�rZl�\k#g�R�~"�\?���:%��%����$�9��6r��+���WIx^l�^̏>�]�i�Ղ��N^ș�}����H�a�+�+��1����Op���������k�s|Ĳcm���>ˎ�h��qK�.�S��Wr)��a��
��o�����G����Rx�G�Y��5��ļ�k�9�[w<qc�P��#QOX�y�kH��J��o�1�!�w�.*�U������+9��.k}��������Y�w���7��o���+!S��n���?��m\\��n��Q����,��n��˟o������̈́�0f�5E �  