
namespace Myzephir;

class Kmeans
{
    public function parseImg(string img)
    {
        var arr = [];
        let arr = getimagesize(img);
        var im, pixel;
        switch (arr[2])
        {  
            // jpg  
            case 2:
                let im = imagecreatefromjpeg(img);
                break;

            // png  
            case 3:
                let im = imagecreatefrompng(img);
                break;

            default:
                echo "image error";
                return;
        }

        int new_width = 100;
        int new_height = 100;
        let pixel = imagecreatetruecolor(new_width, new_height);
        imagecopyresampled(pixel, im, 0, 0, 0, 0, new_width, new_height, arr[0], arr[1]);

        var points = [];
        int i, k;
        let i = new_width;
        while i {
            let k = new_height;
            while k {
                var rgb;
                let rgb = ImageColorAt(im, i, k);
                let points[] = [
                    "r" : (rgb >> 16) & 0xFF,
                    "g" : (rgb >> 8) & 0xFF,
                    "b" : rgb & 0xFF
                ];
                let k -= 1;
            }

            let i -= 1;
        }

        imagedestroy(im);
        imagedestroy(pixel);

        var color = [];
        let color = this->_kmeans(points);  

        print_r(color);
    }


    private function _kmeans(array points, int k=3, int min_diff=1) -> array
    {
        int point_len, i, smallest_distance, distance;
        let point_len = count(points);
        var clusters = [];
        var index;
        var point, key, value, diff;

        let i = k;
        while i {
            let index = mt_rand(1, point_len);
            let clusters[] = points[index];
            // let clusters[] = [points[111], points[2222], points[8888]];
            let i -= 1;
        }

        var point_list = [];
        loop {
            for point in points {
                let smallest_distance = 10000000;
                let index = 0;
                let i = k;

                while i {
                    let distance = 0;
                    for key,value in point {
                        if (value > clusters[i][0][key]) {
                            let diff = value - clusters[i][0][key];
                            let distance += diff * diff;
                        } else {
                            let distance += diff * diff;
                            let diff = clusters[i][0][key] - value;
                        }
                    }
                        
                    if (distance < smallest_distance)
                    {
                        let smallest_distance = distance;
                        let index = i;
                    }
                    
                    let i -= 1;
                }

                let point_list[index] = [];
                array_push(point_list[index], point);
            }

            let diff = 0;
            let i = k;
            var old,center;
            // 1个1个迭代k值
            while i {
                let old = clusters[i];
                let center = this->_calculateCenter(point_list[i], 3);
                let clusters[i] = [center, point_list[i]];
                let diff = this->_euclidean(old[0], center);
                let i -= 1;
            }

            if (diff < min_diff) {
                break;
            }
        }

        return clusters;
    }



    private function _euclidean(array point1, array point2) -> int
    {
        int sum = 0, diff;
        var key, value, value2;
        for key,value in point1 {
            let diff = value - point2[key];
            let sum = sum + (diff * diff);
        }

        return (int)sqrt(sum);
    }


    private function _calculateCenter(array point_list, int attr_num) -> array
    {
        var vals = [], point, key, value;
        int point_num;
        let point_num = count(point_list);

        for point in point_list {
            for key,value in point {
                let vals[key] = 0;
                let vals[key] += value;
            }
        }

        for key,value in point_list[0] {
            let vals[key] = vals[key] / point_num;
        }

        return vals;
    }
}